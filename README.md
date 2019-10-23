# Template Handling
This is a fairly simple routine using Ansible and Packer to build new templates for and inside of VMware, just run the playbook `make_templates.yml`

It also has a playbook for creating the necessary ISO-images for unattended installation in the playbook `make_isos.yml`. This only needs to be run when a new version/flavour is added or any files om them are changed.
