# Github Actions

Github Action to build an image and push to:
- Google Cloud Registry
- DockerHub

## Build and push image to GCR

To build an image and push to GCR, please follow these steps: 
- Create a Service Account
- Add the Cloud Build Service Account role to this Service Account
- Generate a key for this Service Account
- Create a SECRET in your repository named `GCLOUD_SERVICE_ACCOUNT_KEY` with the value of :
  
  -  `cat path-to/key.json | base64 -b 0` for MacOS 

  -  `cat path-to/key.json | base64 -w 0` for Linux 

- Create a SECRET in your repository named `YOUR_GOOGLE_PROJECT` with the value of your Google project-id. 

### Usage

```
      - name: Docker Build
        uses: broadinstitute/dsp-appsec-actions-docker-gcr/build_gcr@master
        env:
          IMAGE: ${{secrets.YOUR_GOOGLE_PROJECT}}/example-app
          GCLOUD_REGISTRY: us.gcr.io

      - name: Docker Push
        uses: broadinstitute/dsp-appsec-actions-docker-gcr/push_gcr@master
        env:
          IMAGE: ${{secrets.YOUR_GOOGLE_PROJECT}}/example-app
          GCLOUD_REGISTRY: us.gcr.io
          GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }} 
```

## Build and push image to DockerHub

To build an image and push to DockerHub please make sure to create two secrets in your repository: 

 - `DOCKER_USERNAME`
 - `DOCKER_PASSWORD`

### Usage

```
      - name: Docker Build
        uses: broadinstitute/dsp-appsec-actions-docker-gcr/build_dockerhub@master
        env:
          IMAGE: example-app
          DOCKERHUB_USERNAME: ${{secrets.DOCKERHUB_USERNAME}}

      - name: Docker Push to Dockerhub
        uses: broadinstitute/dsp-appsec-actions-docker-gcr/push_dockerhub@master
        env:
          IMAGE: example-app
          DOCKERHUB_USERNAME: ${{secrets.DOCKERHUB_USERNAME}}
          DOCKERHUB_PASSWORD: ${{secrets.DOCKERHUB_PASSWORD}}
```

