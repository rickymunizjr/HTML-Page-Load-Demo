<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->





<!-- PROJECT LOGO -->
<br />
<div align="center">
  

  <h3 align="center">HTML Page Load Demo</h3>
  <br />
  <p align="center">
    Proyecto simple para mostrar páginas de HTML desplegadas con Docker y Kubernetes
    <br />
    <br />
  </p>
</div>



### Construido con

* [![Bootstrap][Bootstrap.com]][Bootstrap-url]



<!-- GETTING STARTED -->
## Inicio

Estos son los pasos para correr el ejercicio con Docker y Kubernetes

### Prerequisitos

* Docker
* Kind
* Github Desktop (o algún otro cliente o bash de Git)


### Instalación

1. Clona el siguiente repo a tu máquina local con Github Desktop o algún otro cliente/bash de Git: [https://github.com/rickymunizjr/HTML-Page-Load-Demo.git](https://github.com/rickymunizjr/HTML-Page-Load-Demo.git)

2. Navega al directorio raíz donde clonaste el repo:
    ```sh
    cd 'directorio-raiz-donde-clonaste-el-repo'

    Ejemplo:

    cd Documents/GitHub/HTML-Page-Load-Demo
    ```

3. El dockerfile configurado en la raíz del proyecto estará creando una imagen de Alphine y copiando la parte que despliega el HTML:
    ```docker
    #Usar Nginx como imagen base
    FROM nginx:alpine

    #Copiar los archivos de HTML a la carpeta de Nginx
    COPY html /usr/share/nginx/html
    ```

4. Verifica las imagenes de Docker:
    ```sh
    docker images
    ```

5. Crea la imagen de Docker:
    ```sh
    docker build -t 'nombre-de-la-imagen:numero-de-version-de-la-imagen' .

    Ejemplo:

    docker build -t imagen-page-load:v1 .
    ```

6. Verifica nuevamente las imagenes de Docker:
    ```sh
    docker images
    ```

7. Verifica los clusters de Kind:
    ```sh
    kind get clusters
    ```

8. Crea el cluster de Kind:
    ```sh
    kind create cluster
    ```

9. Verifica nuevamente el cluster de Kind:
    ```sh
    kind get clusters
    ```

10. Valida que el comando de kubectl esté corriendo bien:
    ```sh
    kubectl version
    ```

11. Navega hacia el directorio de los archivos de definición de Kubernetes:
    ```sh
    cd 'directorio-raiz-donde-clonaste-el-repo/k8s'

    Ejemplo:

    cd ../k8s/
    ```

12. Verifica los deployments de Kubernetes:
    ```sh
    kubectl get deployments
    ```

13. Valida que el archivo de definición de "deployment" contenga el nombre y los labels del contenedor que quieres usar y el nombre de la imagen que utilizaste para crearla en Docker:
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: 'nombre-del-contenedor'-deployment
    spec:
      replicas: 'numero-de-pod-replicas-deseado'
      selector:
        matchLabels:
          app: 'nombre-del-contenedor'
      template:
        metadata:
          labels:
            app: 'nombre-del-contenedor'
        spec:
          containers:
          - name: 'nombre-del-contenedor'
            image: 'nombre-de-la-imagen:numero-de-version-de-la-imagen'
            ports:
            - containerPort: 80

    Ejemplo:

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contenedor-page-load-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: contenedor-page-load
      template:
        metadata:
          labels:
            app: contenedor-page-load
        spec:
          containers:
          - name: contenedor-page-load
            image: imagen-page-load:v1
            ports:
            - containerPort: 80
    ```

14. Aplica el archivo de definición de "deployment" para publicar la imagen de Docker en Kubernetes:
    ```sh
    kubectl apply -f 'nombre-del-contenedor'-deployment.yaml

    Ejemplo:

    kubectl apply -f contenedor-page-load-deployment.yaml
    ```

15. Verifica nuevamente los deployments de Kubernetes:
    ```sh
    kubectl get deployments
    ```

16. Registra la imagen de Docker en el "kind-control-plane" para evitar el error del "ImagePullBackOff":
    ```sh
    kind load docker-image 'nombre-de-la-imagen:numero-de-version-de-la-imagen'

    Ejemplo:

    kind load docker-image imagen-page-load:v1
    ```

17. Verifica nuevamente los deployments de Kubernetes:
    ```sh
    kubectl get deployments
    ```

18. Verifica los services de Kubernetes:
    ```sh
    kubectl get services
    ```

19. Valida que el archivo de definición de "service" contenga el nombre y los labels del contenedor que usaste en el archivo de "deployment" y el nombre de la imagen que utilizaste para crearla en Docker:
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: 'nombre-del-contenedor'-service-lb
    spec:
      type: LoadBalancer
      selector:
        app: 'nombre-del-contenedor'
      ports:
      # Default port used by the image
      - port: 80

    Ejemplo:

    apiVersion: v1
    kind: Service
    metadata:
      name: contenedor-page-load-service-lb
    spec:
      type: LoadBalancer
      selector:
        app: contenedor-page-load
      ports:
      # Default port used by the image
      - port: 80
    ```

20. Aplica el archivo de definición de "service" para publicar el URL que accede al contenedor:
    ```sh
    kubectl apply -f 'nombre-del-contenedor'-service-lb.yaml

    Ejemplo:

    kubectl apply -f contenedor-page-load-service-lb.yaml
    ```

21. Verifica nuevamente los services de Kubernetes:
    ```sh
    kubectl get services
    ```

22. Habilita el port forwarding para comunicar el host con el cluster de Kubernetes:
    ```sh
    kubectl port-forward svc/contenedor-page-load-service-lb 'puerto-asignado-al-servicio':80

    Ejemplo:

    kubectl port-forward svc/contenedor-page-load-service-lb 31370:80
    ```

23. Visualiza el contenedor de Kubernetes con el IP del clúster registrado en tu servicio y el puerto utilizado en el archivo de definición de "service". Concatenale al final la dirección de la página HTML que se quiere levantar:
    <pre><p>http://localhost:'puerto-asignado-al-servicio'/cover/index.html</p><p>Ejemplo:</p><p href="http://localhost:31370/cover/index.html">http://localhost:31370/cover/index.html</p></pre>
   

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/rickymunizjr/HTML-Page-Load-Demo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/rickymunizjr/HTML-Page-Load-Demo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/rickymunizjr/HTML-Page-Load-Demo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/rickymunizjr/HTML-Page-Load-Demo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/rickymunizjr/HTML-Page-Load-Demo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 