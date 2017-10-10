{% if grains['os'] == 'Gentoo' %}

include:
  - state.vmware-workstation.deps

layman_vmware:
  layman.present:
    - name: vmware

{% for keyword in 'app-emulation/vmware-workstation','app-emulation/vmware-modules','app-emulation/vmware-tools' %}
{{ keyword }}:
  file.replace:
    - name: /etc/portage/package.unmask/all
    - pattern: .*{{ keyword }}.*
    - repl: {{ keyword }}::vmware
    - append_if_not_found: True
{% endfor %}

vmware-pkgs:
  pkg.installed:
    - names:
      - app-emulation/vmware-modules
      - app-emulation/vmware-tools
      - app-emulation/vmware-workstation

configure:
  cmd.run:
    - name: emerge --config vmware-workstation

vmware_service:
  service:
    - name: vmware
    - running
    - enable: True
    - require:
      - pkg: vmware-pkgs

{% endif %}
