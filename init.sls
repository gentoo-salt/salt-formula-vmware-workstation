{% if grains['os'] == 'Gentoo' %}

include:
  - vmware-workstation.deps

{% set unmask_file = '/etc/portage/package.unmask/all' %}
{% set keywords_file = '/etc/portage/package.accept_keywords/all' %}

layman_vmware:
  layman.present:
    - name: vmware

{% for pkg in 'app-emulation/vmware-workstation','app-emulation/vmware-modules','app-emulation/vmware-tools' %}
keyword-{{ pkg }}:
  file.replace:
    - name: {{ unmask_file }}
    - pattern: .*{{ pkg }}.*
    - repl: {{ pkg }}::vmware
    - append_if_not_found: True
{% endfor %}

{% for pkg in 'dev-util/patchelf','dev-libs/libgcrypt' %}
keyword-{{ pkg }}:
  file.replace:
    - name: {{ keywords_file }}
    - pattern: .*{{ pkg }}.*
    - repl: {{ pkg }}
    - append_if_not_found: True
{% endfor %}

pkg-vmware-workstation:
  pkg.installed:
    - name: app-emulation/vmware-workstation
    - version: latest

configure:
  cmd.run:
    - name: emerge --config vmware-workstation

vmware_service:
  service:
    - name: vmware
    - running
    - enable: True
    - require:
      - pkg: pkg-vmware-workstation

{% endif %}
