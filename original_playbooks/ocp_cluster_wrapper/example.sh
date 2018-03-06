# install
# removed the -k. if needed, add it back
#3.7
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  install/subs_manager.yml --extra-vars "rhn_user={{ lookup ('env', 'RH_USER') }} rhn_pass={{ lookup ('env', 'RH_PASS') }} rhn_pool_id={{ lookup ('env', 'RH_POOL') }} ocp_repos=rhel-7-server-ose-3.7-rpms"

#3.5
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  install/subs_manager.yml --extra-vars "rhn_user={{ lookup ('env', 'RH_USER') }} rhn_pass={{ lookup ('env', 'RH_PASS') }} rhn_pool_id={{ lookup ('env', 'RH_POOL') }} ocp_repos=rhel-7-server-ose-3.5-rpms"


ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  install/install_3rd_party_tools.yml
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  install/docker_install.yml 
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  install/ocp_cluster_up.yml

#uninstall
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/unsub_manager.yml
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/uninstall_3rd_party_tools.yml
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/docker_uninstall.yml 
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/ocp_cluster_down.yml --extra-vars "mode=destroy force_oc_rm=true"
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/ocp_cluster_down.yml --extra-vars "mode=destroyClusterOnly"
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE -i ../hosts  uninstall/ocp_cluster_down.yml --extra-vars "mode=down"

#for roles when down and destroyClusterOnly, set all the other uninstalls to false
