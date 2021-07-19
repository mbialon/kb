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
    when: config_names | length > 0
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

## Module architecture

[https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html#argument-spec](https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html#argument-spec)

## Manage lines in text files

```
- name: Ensure SELinux is set to enforcing mode
  ansible.builtin.lineinfile:
    path: /etc/selinux/config
    regexp: '^SELINUX='
    line: SELINUX=enforcing
```

[ansible.builtin.lineinfile](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html)
