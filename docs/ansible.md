# Ansible

## Raw module

[https://docs.ansible.com/ansible/latest/modules/raw_module.html](https://docs.ansible.com/ansible/latest/modules/raw_module.html)

## Loops and handlers

```
tasks:
  - name: Copy config
    template:
      src: "config/{{ item }}.yml"
      dest: "{{ ansible_user_dir }}/config/{{ item }}.yml"
    loop: "{{ config_names }}"
    register: config_files
    notify:
      - Restart service

handlers:
  - name: Restart service
    community.docker.docker_compose:
      project_src: app
      restarted: yes
      services:
        - "svc_{{ item }}"
    when: item.changed
    loop: config_files.results
```
