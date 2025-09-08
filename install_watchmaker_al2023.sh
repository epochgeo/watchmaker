# Could not get this to install w/o sudo
#
# scap profiles:
#
# (verify with: oscap info "/home/ec2-user/watchmaker/src/watchmaker/static/salt/formulas/scap-formula/scap/content/guides/openscap/ssg-al2023-ds.xml)"
#
# xccdf_org.ssgproject.content_profile_cis_server_l1
# xccdf_org.ssgproject.content_profile_cis
# xccdf_org.ssgproject.content_profile_stig
#
# You should be able to set the profile from config.yaml but was unable. Had to set it in:
# watchmaker/src/watchmaker/static/salt/formulas/scap-formula/scap/oscap/scan.sls 
#
# Also had to make changes to forked ash-linux-formula and scap-formula submodules for hardening and reporting
# to work.

sudo curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo \
  | sudo tee /etc/yum.repos.d/salt.repo
sudo dnf clean expire-cache
sudo dnf install salt-minion salt-master -y
sudo systemctl enable salt-minion
sudo systemctl start salt-minion
# sudo systemctl enable salt-master
# sudo systemctl start salt-master

sudo dnf install git

sudo python3 -m ensurepip --upgrade

python3 -m pip install build wheel setuptools

git clone https://github.com/plus3it/watchmaker.git --recursive && cd watchmaker
git submodule update --init --recursive
git checkout 0.29.4
sudo python3 -m pip install -e .

sudo cp -R ~/watchmaker/src/watchmaker/static/salt/formulas/ash-linux-formula/ash-linux/el9 ~/watchmaker/src/watchmaker/static/salt/formulas/ash-linux-formula/ash-linux/el2023

sudo watchmaker –no-reboot --config /home/ec2-user/watchmaker/src/watchmaker/static/config.yaml
