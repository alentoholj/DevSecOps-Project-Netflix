[![Build Status](https://dev.azure.com/carpel1921/Netflix/_apis/build/status%2Falentoholj.DevSecOps-Project-Netflix?branchName=main)](https://dev.azure.com/carpel1921/Netflix/_build/latest?definitionId=13&branchName=main)

# DevSecOps Project CI/CD Flow

![DevSecOps-Netflix](https://github.com/alentoholj/DevSecOps-Project-Netflix/assets/82238804/eff70b24-821f-4175-82fd-e10f1e174d6a)

## Prerequisites for this project:

- Azure Subscription
- Azure DevOps account
- Dockerhub account
- GitHub
- SonarCloud account
- Trivy
- Slack
- TMDB account

# Deploy Netflix App to Azure Web Service using Azure DevOps Pipelines

## Phase 1: Initial setup and run the application locally

Step 1: Clone the Code

- Update all the packages on the OS and then clone the repo
- Clone the application code repository onto the local machine

      git clone https://github.com/alentoholj/DevSecOps-Project-Netflix.git

Step 2: Install Docker and Run the application locally

- Set up Docker on your instance

        sudo apt-get update
        sudo apt-get install docker.io -y
        sudo usermod -aG docker $USER  # Replace with your system's username, e.g., 'ubuntu'
        newgrp docker
        sudo chmod 777 /var/run/docker.sock

- Build and run the application locally using a Docker container

        docker build -t netflix .
        docker run -d --name netflix -p 8081:80 netflix:latest

        #to delete
        docker stop <containerid>
        docker rmi -f netflix

After you run the container, you will not be able to see films, series, etc. The reason for that is that you need to have an API key to fetch The Movie Database from TMDB.

- Create an account on https://www.themoviedb.org and get the API key

  How to get an API key:

  - Go to your profile and select Settings
  - Click on "API" from the left side panel.
  - Click on "Create" and accept the terms and conditions
  - Before you click on the "Submit" button, fill out the required properties.
  - After Submit, you will receive your API key

- Recreate Docker image but with API key which you get from TMDB

          docker build --build-arg TMDB_V3_API_KEY=<your-api-key> -t netflix .

Again, run the Docker container but in this case, you will be able to see the Netflix app with films, series, etc.

## Phase 2: Create an account on SonarCloud and install Trivy locally

- Create a SonarCloud account

    - Go to SonarCloud.io
    - Login into SonarCloud with GitHub
    - Click on "Analyze new project"
    - Than "Import a new organization"
    - Put the name of the organization
    - Choose a Free Plan for SonarCloud
    - Import the repo
    - Disable Automatic analysis
 
- Install Trivy on your local machine

        sudo apt-get update
        sudo snap install trivy

- Test Trivy

        trivy image carpel/netflix

## Phase 3: Add service connections on the Azure DevOps

To add service connections you will need to go to the Project settings --> Service Connections.

In this section, you must add the connection to:

- GitHub account
- Dockerhub
- Azure Subscription
- SonarCloud

![Screenshot from 2023-12-05 01-04-37](https://github.com/alentoholj/DevSecOps-Project-Netflix/assets/82238804/d9c824d7-47cc-4998-8a92-83c35b249c25)

The explanation of the service connections on the Azure DevOps, you have on the link below:

https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml

## Phase 4: Create an agent pool and add a self-hosted agent to the pool

To create an agent pool:

- Go to Azure DevOps
- On the bottom left, go to Project Settings
- Click on the Agent Pools
- Create an agent pool
- Open the newly created agent pool
- On the right side, click on "New agent"
- Run the script, on the machine where you want to have your agent

Of course, you don't need to create an agent pool and the agent, because you can use a default one on the Azure DevOps.

![Screenshot from 2023-12-05 01-02-40](https://github.com/alentoholj/DevSecOps-Project-Netflix/assets/82238804/5e843338-5a4e-4083-bbf7-01fb598fea46)
