- run the script: `./setup.sh`
- this line you must uncomment "sleep", comment "daemon" and start container:
- enter interactive mode using:
    - ```bash
      sudo docker compose exec -it runner forgejo-runner register
      ```
- enter all the required data:
    - if the runner is on the same machine, you can specify the local ip address
- comment the "sleep" and uncomment "daemon" line:
    - ```yaml
- runner is created
