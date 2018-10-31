#tearDown
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts tear_down_oc_cluster_aws.yml  --extra-vars "cluster_name=ocp-cluster"
