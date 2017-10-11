{% if grains['os'] == 'Gentoo' %}

include:
  - state.vmware-workstation.deps

layman_vmware:
  layman.present:
    - name: vmware

{% for pkg in 'app-emulation/vmware-workstation','app-emulation/vmware-modules','app-emulation/vmware-tools' %}
keyword-{{ pkg }}:
  file.replace:
    - name: /etc/portage/package.unmask/all
    - pattern: .*{{ pkg }}.*
    - repl: {{ pkg }}::vmware
    - append_if_not_found: True

package-{{ pkg }}:
  pkg.installed:
    - pkgs:
      - {{ pkg }}
{% endfor %}

configure:
  cmd.run:
    - name: emerge --config vmware-workstation

vmware_service:
  service:
    - name: vmware
    - running
    - enable: True
    - require:
      - pkg: package-app-emulation/vmware-workstation

{% endif %}
