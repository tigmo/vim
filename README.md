# vim
Personal vim scripts

# Requirements/Installation of plugins

Clone
[Vundle](https://github.com/VundleVim/Vundle.vim)
into `~/.vim/bundle/Vundle.vim`

	 git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Open vim and run

	:PluginInstall

Install requirements for
[YCM](https://github.com/ycm-core/YouCompleteMe)

- `base-devel cmake python3`
- `mono go nodejs npm jdk|jdk-openjdk`

Install YCM

	cd ~/.vim/bundle/YouCompleteMe
	python3 install.py --all
