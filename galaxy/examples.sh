ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts oc_cluster_up_aws.yml --extra-vars "rhn_user={{ lookup ('env', 'RH_USER') }} rhn_pass={{ lookup ('env', 'RH_PASS') }} rhn_pool_id={{ lookup ('env', 'RH_POOL') }} ocp_repos=rhel-7-server-ose-3.7-rpms cluster_name=ocp-cluster"

#down
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts down_oc_cluster.yml

#destroyCluster
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts destroy_oc_cluster.yml --extra-vars "cluster_name=ocp-cluster"

#restart cluster
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts up_existing_cluster.yml --extra-vars "cluster_name=ocp-cluster"

#tearDown
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts tear_down_oc_cluster_aws.yml  --extra-vars "cluster_name=ocp-cluster"
