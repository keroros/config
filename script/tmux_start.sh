#!/bin/bash

cd ~/

tmux new-session -d -s mysession

tmux split-window -v

tmux select-pane -t 0
tmux split-window -h

tmux select-pane -t 2
tmux split-window -h

tmux select-pane -t 0

tmux attach-session -t mysession
