#!/bin/sh
session="main" # set up tmux tmux start-server
SESSIONEXISTS=$(tmux list-sessions | grep $session)

if [ "$SESSIONEXISTS" = "" ]
then
  # create a new tmux session, starting a new vim session
  tmux new-session -d -s $session -n editor
  tmux send-keys "cd \$HOME/Code/arize" C-m
  tmux send-keys "conda activate py310" C-m
  tmux send-keys "v" C-m

  # --- shell window ---
  tmux new-window -n 'shell'
  tmux send-keys "cd \$HOME/Code/arize" C-m
  tmux send-keys "conda activate py310" C-m
  tmux send-keys "c" C-m

  # 50/50 left/right
  tmux splitw -h -p 50

  # RIGHT pane: split into 3 vertical panes (33/33/33)
  tmux select-pane -t 1
  tmux send-keys "cd \$HOME/Code/arize" C-m
  tmux send-keys "conda activate py310" C-m
  tmux send-keys "c" C-m

  # first vertical split (top 66%, bottom 33%)
  tmux splitw -v -p 75
  tmux send-keys "cd \$HOME/Code/arize" C-m
  tmux send-keys "conda activate py310" C-m
  tmux send-keys "c" C-m

  # split the top-right pane again to make 33/33/33
  tmux select-pane -t 1
  tmux splitw -v -p 50
  tmux send-keys "cd \$HOME/Code/arize" C-m
  tmux send-keys "conda activate py310" C-m
  tmux send-keys "c" C-m

  # return to main vim window
  tmux select-window -t 'editor'
  tmux select-pane -t 1

  # attach
  tmux attach-session -t $session
fi
