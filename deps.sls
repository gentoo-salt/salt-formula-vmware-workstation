{% for item in [{'CONFIG_VMWARE_VMCI':'m', 'CONFIG_VMWARE_VMCI_VSOCKETS':'m','CONFIG_FUSION':'y','CONFIG_FUSION_SPI':'y'}] %}
  {% for option, value in item.iteritems() %}
    {{ option }}:
      module.run:
        - name: kernel.is_option_set_to
        - option: {{ option }}
        - value: {{ value }}
  {% endfor %}
{% endfor %}
