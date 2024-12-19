function start_ssh_agent
  eval (ssh-agent -c)
  #ssh-add ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa_p1neapple
end