require 'rake'
require 'fileutils'
require 'English'
require File.join(File.dirname(__FILE__), 'bin', 'other', 'vundle')

desc 'Hook our dotfiles into system-standard positions.'
task install: %i[submodule_init submodules] do
  puts
  puts '======================================================'
  puts 'Installing setup.'
  puts '======================================================'
  puts

  install_homebrew

  # this has all the runcoms from this directory.
  install_files(Dir.glob('git/*')) if want_to_install?('git configs (color, aliases)')
  install_ctags if want_to_install?('ctags config (TypeScript/Python/Go)')
  install_files(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  install_files(Dir.glob('vimify/*')) if want_to_install?('vimification of command line tools')
  if want_to_install?('vim configuration (highly recommended)')
    install_files(Dir.glob('{vim,vimrc}'))
  end

  Rake::Task['install_plugins'].execute

  if want_to_install?('neovim, lunarvim, and fonts')
    install_nvim
    install_lvim
    install_fonts
  end

  success_msg('installed')
end

desc 'Generate ctags for the current directory: rake -f ~/.jp_setup/Rakefile tags'
task :tags do
  run %( ctags -R . )
end

task :install_plugins do
  install_plugins if want_to_install?('zsh enhancements & prezto')
end

desc 'Updates the installation'
task :update do
  Rake::Task['install'].execute
end

task :submodule_init do
  run %( cd $HOME/.jp_setup && git submodule update --init --recursive ) unless ENV['SKIP_SUBMODULES']
end

desc 'Init and update submodules.'
task :submodules do
  unless ENV['SKIP_SUBMODULES']
    puts '======================================================'
    puts 'Downloading submodules...please wait'
    puts '======================================================'

    run %(
      cd $HOME/.jp_setup
      git submodule update --recursive
    )

    run %( git clean -df ) if ENV['CLEAN']
    puts
  end
end

task default: 'install'

private

def run(cmd)
  puts "[Running] #{cmd}"
  return if ENV['DEBUG']

  ok = system(cmd)
  raise "Command failed (exit #{$CHILD_STATUS.exitstatus}): #{cmd}" unless ok
end

def run_allow_fail(cmd)
  puts "[Running] #{cmd}"
  return true if ENV['DEBUG']
  system(cmd)
end

def in_repo
  %($HOME/.jp_setup)
end

def ensure_submodule(url, path)
  repo_root = File.join(ENV['HOME'], '.jp_setup')
  gitmodules = File.join(repo_root, '.gitmodules')

  # If already listed in .gitmodules, we're good.
  if File.exist?(gitmodules) && File.read(gitmodules).include?(path)
    return
  end

  # If the directory exists but isn't a registered submodule, bail with guidance.
  full_path = File.join(repo_root, path)
  if File.exist?(full_path) && !(File.exist?(gitmodules) && File.read(gitmodules).include?(path))
    raise "Path exists but is not a submodule: #{full_path}. Remove it or convert it, then rerun."
  end

  run %(
    cd #{in_repo}
    mkdir -p "#{File.dirname(path)}"
    git submodule add "#{url}" "#{path}"
  )
end


def update_submodules
  run %(
    cd #{in_repo}
    git submodule update --init --recursive
  )
end

def install_homebrew
  run %(which brew)
  unless $CHILD_STATUS.success?
    puts '======================================================'
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts 'already installed, this will do nothing.'
    puts '======================================================'
    run %{/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"}
  end

  puts
  puts
  puts '======================================================'
  puts 'Updating Homebrew.'
  puts '======================================================'
  run %(brew update)
  puts
  puts
  puts '======================================================'
  puts 'Installing Homebrew packages...There may be some warnings.'
  puts '======================================================'
  run %(brew install zsh universal-ctags git hub tmux reattach-to-user-namespace the_silver_searcher ghi fontconfig fzf ripgrep fd tree-sitter)
  puts
  puts
end

def install_fonts
  puts '======================================================'
  puts 'Installing patched fonts for Powerline/Lightline.'
  puts '======================================================'
  run %( cp -f $HOME/.jp_setup/fonts/* $HOME/Library/Fonts ) if RUBY_PLATFORM.downcase.include?('darwin')
  if RUBY_PLATFORM.downcase.include?('linux')
    run %( mkdir -p ~/.fonts && cp ~/.jp_setup/fonts/* ~/.fonts && fc-cache -vf ~/.fonts )
  end
  run %( mkdir -p ~/.local/share/fonts && ln -nfs "$HOME/.jp_setup/fonts" "$HOME/.local/share/fonts" )
  puts
end

def install_nvim
  puts
  puts 'installing neovim'

  if RUBY_PLATFORM.downcase.include?('darwin')
    run %( brew install neovim )
  elsif RUBY_PLATFORM.downcase.include?('linux')
    # Choose one (package manager varies). This is a reasonable default:
    run %( sudo apt-get update && sudo apt-get install -y neovim )
  else
    puts 'Unknown platform; skipping neovim install'
  end

  puts
  puts 'symlinking neovim config'
  run %( mkdir -p "$HOME/.config" )
  run %( ln -nfs "$HOME/.jp_setup/nvim/config" "$HOME/.config/nvim" )
end

def install_lvim
  puts
  puts 'installing lunarvim'

  run %( command -v nvim ) # fail early if nvim missing

  # Ensure common XDG dirs exist (installer can be picky)
  FileUtils.mkdir_p(File.join(ENV['HOME'], '.config', 'lvim'))
  FileUtils.mkdir_p(File.join(ENV['HOME'], '.local', 'bin'))
  FileUtils.mkdir_p(File.join(ENV['HOME'], '.local', 'share'))

  # Run installer non-interactively (auto-yes to deps prompts)
  ok = run_allow_fail(%(
    yes | curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh \
    | LV_BRANCH='master' bash
  ))

  lvim_path = File.join(ENV['HOME'], '.local', 'bin', 'lvim')

  unless ok
    if File.exist?(lvim_path)
      puts "[Warn] LunarVim installer exited non-zero during plugin verification."
      puts "       LunarVim is installed at: #{lvim_path}"
    else
      raise "LunarVim installer failed and lvim was not installed."
    end
  end

  puts
  puts 'symlinking lunarvim config'
  run %( ln -nfs "$HOME/.jp_setup/lunarvim/config" "$HOME/.config/lvim" )

  puts
  puts 'ensuring lvim is on PATH'
  run %( test -x "#{lvim_path}" )

  run %( grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.jp_setup/zsh/zshrc" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.jp_setup/zsh/zshrc" )

  # Best-effort first-time plugin sync (non-fatal)
  puts
  puts 'attempting first-time plugin sync (non-fatal if it fails)'
  run_allow_fail(%( "#{lvim_path}" +PackerSync +q ))
  run_allow_fail(%( "#{lvim_path}" +LvimSyncCorePlugins +q ))

  puts
  puts "If plugins still look off, run: lvim then :PackerSync (or :LvimSyncCorePlugins) once."
end

def install_plugins
  puts
  puts 'Installing ZSH Enhancements...'

  run %( ln -nfs "$HOME/.jp_setup/zsh/zshrc" "$HOME/.zshrc" )
  run %( mkdir -p "$HOME/.jp_setup/zsh/zsh/ohmyzsh/custom/plugins" )
  run %( mkdir -p "$HOME/.jp_setup/zsh/zsh/ohmyzsh/custom/themes" )

  ensure_submodule('https://github.com/ohmyzsh/ohmyzsh', 'zsh/zsh/ohmyzsh')
  ensure_submodule('https://github.com/junegunn/fzf', 'zsh/zsh/fzf')
  update_submodules

  run %(
    cd $HOME/.jp_setup/zsh/zsh/ohmyzsh/custom/plugins
    [ -d zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    [ -d zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions.git
    cp $HOME/.jp_setup/zsh/cobalt2.zsh-theme $HOME/.jp_setup/zsh/zsh/ohmyzsh/custom/themes
  )

  if "#{ENV['SHELL']}".include? 'zsh'
    puts 'Zsh is already configured as your shell of choice. Restart your session to load the new settings'
  else
    puts 'Setting zsh as your default shell'
    if File.exist?('/usr/local/bin/zsh')
      if File.readlines('/private/etc/shells').grep('/usr/local/bin/zsh').empty?
        puts 'Adding zsh to standard shell list'
        run %( echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells )
      end
      run %( chsh -s /usr/local/bin/zsh )
    else
      run %( chsh -s /bin/zsh )
    end
  end
end

def want_to_install?(section)
  puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
  $stdin.gets.chomp == 'y'
end

def install_files(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV['PWD']}/#{f}"
    target = "#{ENV['HOME']}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    if method == :symlink
      run %( ln -nfs "#{source}" "#{target}" )
    else
      run %( cp -f "#{source}" "#{target}" )
    end

    puts '=========================================================='
    puts
  end
end

def install_ctags
  puts
  puts '======================================================'
  puts 'Installing Universal Ctags config'
  puts '======================================================'

  run %( mkdir -p "$HOME/.ctags.d" )

  # Symlink every file in repo ctags/ctags.d into ~/.ctags.d
  Dir.glob(File.join(ENV['HOME'], '.jp_setup', 'ctags', 'ctags.d', '*')).each do |src|
    next unless File.file?(src)
    base = File.basename(src)
    run %( ln -nfs "#{src}" "$HOME/.ctags.d/#{base}" )
  end

  # Optional: sanity check what ctags you have
  run %( command -v ctags )
  run %( ctags --version )
end

def success_msg(action)
  puts "Setup has been #{action}. Please restart your terminal and vim."
end
