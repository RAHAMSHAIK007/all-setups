- hosts: test
  tasks:
    - name: installing apache server
      yum: name=httpd state=present

    - name: activating apache server
      service: name=httpd state=started

    - name: installing git
      yum: name=git state=present

    - name: git checkout
      git:
        repo: "https://github.com/CleverProgrammers/pwj-netflix-clone.git"
        dest: "/var/www/html"
