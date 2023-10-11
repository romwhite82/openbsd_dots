 userresources=$HOME/.Xresources
 usermodmap=$HOME/.Xmodmap
  
    if [ -f "$userresources" ]; then
          xrdb -merge "$userresources"
      fi
      if [ -f "$usermodmap" ]; then
          xmodmap "$usermodmap"
      fi


      if [ -z "$SSH_AGENT_PID" ] && [ -x /usr/bin/ssh-agent ]
      then
      	for k in id_rsa id_ecdsa id_ecdsa_sk id_ed25519 id_ed25519_sk id_dsa
      	do
      		if [ -f "$HOME/.ssh/$k" ]; then
      			eval `ssh-agent -s`
      			ssh-add < /dev/null
      			break
      		fi
      	done
      fi
exec fvwm3
