#!/bin/sh
set -eu

session="main"
root="$HOME/Code/arize"
env_cmd="conda activate py311"

# Saved (captured) layout for your usual terminal size
shell_layout='8aff,341x64,0,0[341x17,0,0{82x17,0,0,1,118x17,83,0,3,139x17,202,0,4},341x46,0,18,2]'
shell_layout_size="341x64"

tmux start-server

# If session exists, attach
if tmux has-session -t "$session" 2>/dev/null; then
  exec tmux attach -t "$session"
fi

# --------------------
# Window 1: editor
# --------------------
tmux new-session -d -s "$session" -n editor
tmux send-keys -t "$session:editor" "cd \"$root\"" C-m
tmux send-keys -t "$session:editor" "$env_cmd" C-m
tmux send-keys -t "$session:editor" "v" C-m

# --------------------
# Window 2: shell
# --------------------
tmux new-window -t "$session" -n shell

# Helper: initialize all panes in shell
init_shell_panes() {
  for pane in $(tmux list-panes -t "$session:shell" -F '#{pane_id}'); do
    tmux send-keys -t "$pane" "cd \"$root\"" C-m
    tmux send-keys -t "$pane" "$env_cmd" C-m
    tmux send-keys -t "$pane" "c" C-m
  done
}

# Try applying saved layout only if window size matches; otherwise fallback to % splits.
current_size="$(tmux display-message -p -t "$session:shell" '#{window_width}x#{window_height}')"

if [ "$current_size" = "$shell_layout_size" ] && tmux select-layout -t "$session:shell" "$shell_layout" 2>/dev/null; then
  # Saved layout applied
  init_shell_panes
else
  # -------- Fallback: build the intended layout via pane IDs (size-independent)
  # Target:
  #   Top 30%: 3 panes (20% / 40% / 40%)
  #   Bottom 70%: 1 pane full width

  # Start with the only pane in the shell window
  top_left="$(tmux display-message -p -t "$session:shell" '#{pane_id}')"

  # Split to create bottom pane (new pane size = 70% height)
  bottom="$(tmux split-window -t "$top_left" -v -p 70 -P -F '#{pane_id}')"

  # Split top into left 20% and right 80% (new pane size = 80% width => right side)
  right_80="$(tmux split-window -t "$top_left" -h -p 80 -P -F '#{pane_id}')"

  # Split right_80 into two equal halves (50/50 of 80% => 40/40 of total)
  right_40="$(tmux split-window -t "$right_80" -h -p 50 -P -F '#{pane_id}')"
  middle_40="$right_80"

  # Initialize all panes (top-left, middle, right, bottom)
  for pane in "$top_left" "$middle_40" "$right_40" "$bottom"; do
    tmux send-keys -t "$pane" "cd \"$root\"" C-m
    tmux send-keys -t "$pane" "$env_cmd" C-m
    tmux send-keys -t "$pane" "c" C-m
  done
fi

# Back to editor + attach
tmux select-window -t "$session:editor"
exec tmux attach -t "$session"
