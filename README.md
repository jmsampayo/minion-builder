# minion-builder

Docker image to deploy and run Jenkins agents intended to be used as builders for:

- Infrastructure deployment and maintenance.
- **Node.Js** based applications build and deploy.

---

## Software and Packages

- openJDK 21 JRE
- Jenkins agent (agent.jar)
- bash curl git openssh unzip wget zip

---

## Usage

### **NOTE**

***Do NOT pull the image from this repo. It's built with the agent downloaded from our Jenkins server; so if the version of your Jenkins server is different, the run container may not work properly.***

### Docker build

```shell
docker build --build-arg AGENT_JAR_URL=<your Jenkins agent jar URL> -t minion-builder .
```

### Docker run

```shell
docker run -d --name minion-builder-01 --restart always minion-builder:latest -url <your Jenkins URL> -secret <your Jenkins agent secret> -name <your Jenkins agent name> -workDir /home/jenkins
```
