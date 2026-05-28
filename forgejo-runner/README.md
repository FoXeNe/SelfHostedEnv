- run the script: `./setup.sh`
- this line will be uncommented:
    - ```yaml
      command: '/bin/sh -c "while : ; do sleep 1 ; done ;"'
      ```
- enter interactive mode using the "sleep" command:
    - ```bash
      sudo docker compose exec -it runner forgejo-runner register
      ```
- enter all the required data:
    - if the runner is on the same machine, you can specify the local ip address
- uncomment the "daemon" line:
    - ```yaml
      command: /bin/sh -c "sleep 5; forgejo-runner daemon --config /data/config.yml"
      ```
    - comment out the "sleep" line
- runner is created
