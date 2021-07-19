# Ansible

## Raw module

```
- name: Bootstrap a host without python2 installed
  raw: dnf install -y python2 python2-dnf libselinux-python
```

Links:

- [https://docs.ansible.com/ansible/latest/modules/raw_module.html](https://docs.ansible.com/ansible/latest/modules/raw_module.html)

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

Links:
- [https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html#argument-spec](https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html#argument-spec)

## Manage lines in text files

```
- name: Ensure SELinux is set to enforcing mode
  ansible.builtin.lineinfile:
    path: /etc/selinux/config
    regexp: '^SELINUX='
    line: SELINUX=enforcing
```

Links:

- [ansible.builtin.lineinfile](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html)

## Format data to JSON and YAML

- `to_json`
- `to_yaml`
- `to_nice_json`
- `to_nice_yaml`

```
- name: Configure Docker daemon options.
   copy:
     content: "{{ docker_daemon_options | to_nice_json }}"
     dest: /etc/docker/daemon.json
     mode: 0644
   when: docker_daemon_options.keys() | length > 0
   notify: restart docker
```

Links:

- [formatting-data-yaml-and-json](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#formatting-data-yaml-and-json)
