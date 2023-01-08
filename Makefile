.PHONY: install
install:
	vagrant plugin install dotenv
	vagrant plugin install vagrant-vbguest

.PHONY: up
up: install
	$env:VAGRANT_EXPERIMENTAL = 'disks'; vagrant up

.PHONY: vagrant-validate
vagrant-validate: install
	vagrant validate

.PHONY: shellcheck
shellcheck:
	shellcheck provision_root.sh
	shellcheck provision_nonroot.sh

.PHONY: dump-version
dump-version:
	bash dump_version.sh
