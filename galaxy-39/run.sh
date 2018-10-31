#3.9
echo "Instaling......"
ansible-playbook -u ec2-user --private-key $AWS_PEM_FILE  -i ./hosts oc_cluster_up_aws.yml --extra-vars "rhn_user={{ lookup ('env', 'RH_USER') }} rhn_pass={{ lookup ('env', 'RH_PASS') }} rhn_pool_id={{ lookup ('env', 'RH_POOL') }} ocp_repos=rhel-7-server-ose-3.9-rpms cluster_name=ocp-cluster"
