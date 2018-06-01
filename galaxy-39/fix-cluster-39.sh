#may need to prepare cluster first
#also may need to stop all running containers and destroy images
#oc-cluster-wrapper/oc-cluster down ocp-cluster
#oc-cluster-wrapper/oc-cluster destroy ocp-cluster
oc cluster up --public-hostname $EXTERNAL_IP --routing-suffix apps.$EXTERNAL_IP.nip.io --host-data-dir /root/.oc/profiles/ocp-cluster/data --host-config-dir /root/.oc/profiles/ocp-cluster/config --host-pv-dir /root/.oc/profiles/ocp-cluster/pv
#any user is sudo
oc  adm policy add-cluster-role-to-group sudoer system:authenticated --config=.oc/profiles/ocp-cluster/config/master/admin.kubeconfig
#add admin and system as cluster admins
oc  adm policy add-cluster-role-to-user cluster-admin admin --as=system:admin
oc  adm policy add-cluster-role-to-user cluster-admin system --as=system:admin

#hawkular "maybe" fix
oc adm policy add-role-to-user view system:serviceaccount:openshift-infra:hawkular -n openshift-infra --as=system:admin 1> /dev/null


docker stop origin &> /dev/null && docker start origin &> /dev/null


