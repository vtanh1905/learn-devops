NashTech

- Tạo reponstory theo <staffcode_practical_devops> ⇒ Tạo source đã cung cấp và build docker image + docker compose

- Handon Dockerfile build with file env vs Run Container with file env
    
    ## dev.env
    DB_HOST=localhost
    DB_PORT=3306
    DEBUG=true
    
    prod.env
    DB_HOST=production_db_host
    DB_PORT=5432
    DEBUG=false
    
    Dockerfile
    
    # Set default values for environment variables
    
    ENV DB_HOST=localhost
    ENV DB_PORT=3306
    ENV DEBUG=true
    
    - Building the Docker Image:
    build the image for the development environment:
    docker build --env-file=dev.env -t my_image:dev .
        
        ```
           production environment:
            docker build --env-file=prod.env -t my_image:prod .
        
        ```
        
    - Running the Docker Container:
    development environment:
    docker run --env-file=dev.env my_image:dev
        
        ```
           production environment:
           docker run --env-file=prod.env my_image:prod
        
        ```
        
- Handon DockerFile with USER
- Handon DockerFile with multi Stage create-react-app vs nginx
- Handon Docker Hub
- Handon Nginx with staging
- Handon Docker Registry + Authentication(Nginx + htpasswd + Docker Registry)
- Handon Nngix + Https (openssl)
- Handon docker restart
- Handon docker-compose health-check
- Handon cài đặt Minikube, start Minikube, Dashboard Minikube
- Handon VNWARE + Vagrant
- Handon Setup Cluster Kubenets (VNWARE + VAGRANT + INSTALL DOCKER + INSTALL KUBECTL, KUBEADMIN + FLATTEN NETWORK CALICO NETWORK)
    - Calico Network: giúp chúng ta set up network cho kubenets cluster để các node có thể giao tiếp được với nhau, bên cạnh đó nó còn thêm nhiều tính năng bảo mật
    - Setup sao cho Master Node vs Worker Node ping được với nhau
    - Vagrant có hỗ trợ [install.sh](http://install.sh) (follow theo gì đó để bik cái kubernets + docker các thành phần cần có của Node trong Kubernets)
    - Xóa containerd và restart docker để lấy config mới ?
    - Có 1 câu lệnh giúp t join 1 node worker vào cluster
    
- Handon các câu lệnh kubectl
- Handon thử apply pod.yaml
    - multi container
    - cpu and memory
    - Thử livenessProbe + readinessProbe
    - Thử nodeName + NodeSelector
    - Thử Affinity (with labelSelector có thể cho labels là gì đó cũng dc vd như name hay environment)
    - Namespace
        - tạo 1 namesapce
        - ResourceQuota (limit resource cho 1 namespace )
        - ResourceQuota (limit object)
        - Taọ nhiều ResourceQuota trong 1 namespace
    - Label
        - Tạo thử 1 label
    - Service
        - type: ClusterIP
            - Tạo simple serivce export port 80  type: ClusterIP
            - **`Tạo Endpoint và Service làm sao để chúng có thể link lại với nhau`**
            - Thử create 1 pod trong 1 service type: ClusterIP (để ý cái selector của service)
            - Tạo 2 pod cùng 1 service with type ClusterIP. Rồi Exec vào 1 trong 2 pod đó xem có ping được nhau không
            - Tạo 1 service type: ClusterIP và export ra 2 ports. Ứng với mỗi pod tới 1 container khác nhau trong 1 pod
            - `**⇒ Khi một service export 2 port (1 port là nginx, 2 là redis) thì làm sao 1 pod nằm ngoài service này mà curl tới chỉ vào 1 port duy nhất là nginx**`
            
            ![Untitled](https://github.com/vtanh1905/learn-devops/assets/49771724/643afa19-20f5-4d7b-9836-15d70d053bd4)

            
            - Giờ cho 2 pod call qua lại nhau nhưng mà
                - Khác service (sài name service hay nói là service discorvery để ping qua lại nhau)
                - Khác namespace (sài DNS) `<service-name>.<namespace-name>.svc.cluster.local`
        
        - type: NodePort
            - Handon tạo service với type NodePort, tạo thêm 1 pod nằm trong service đó.
                - Và thử đừng ở node-master để curl cái pod đó
                - Và thử truy cấp vào pod đó từ máy tính của mình hog phải là node
            - Handon `**⇒ Khi một service export 2 port (1 port là nginx, 2 là redis) thì làm sao 1 pod nằm ngoài service này mà curl tới chỉ vào 1 port duy nhất là nginx` giải quyết này 
            Config sao cho nó mỗi pod có 1 port riêng dù  2 container nginx vs redis nằm trong 1 pod hoặc khác pod**
        - type: LoadBalancer
            - Handon tạo 1 service với type là LoadBalancer và 3 pod nằm trong service đó. Đừng ở 1 pod khác và call thử tới service đó xem có round-robin hog
        
        - type: Headless Service (in file yaml clusterIP:  none)
            - Handon   tạo 1 service với type ClusterIP và clusterIP: None và có 2 pod nằm trong service đó. Đừng ở 1 pod khác và call thử. Sài thử nslookup để xem danh sách IP của service đó
                - Thử call tới từ địa chị IP trong danh sách IP đó `<pod-ip>.<service-name>.<namespace-name>.svc.cluster.local`
            - Handon tạo 2 pod nginx có hostname + subdomain nằm trong 1 headless service
                - Ở 1 pod khác curl qua 2 pod nginx trên thông qua hostname+subdomain  (Note: name của service phải cùng vs name của subdomain)
                
        - type: ExternalName Service
            - Handon Tạo một ExternalName Service simple với google.com
            - Sau đó. Sài nslookup với service trên mà xem thử cách nó chạy phân rã DNS
            - Tiếp theo, Coi configmap của kube-system và edit config thêm cho sao nó có thể phân rã tên miền google.com
            - Cuối cùng, Sài nslookup ở 1 pod để nslookup tới service trên xem phân rã DNS tới google chưa
            
        - type: Ingress
            - Setup Ingress Controller vơi minikube
            
    
    - Workload Resource
        - ReplicationController
            - Handon Tạo pod nginx bằng replication controller với replicas = 3
            - Handon Tạo pod bình thường với label app:web và 1 replication controller với replicas = 2 có selector là label trên ⇒ xem chuyển gì xảy ra (Khi này replication controller chỉ create 1 pod)
            
        
        - ReplicaSet
            - Handon Tạo pod nginx bằng replicaset với replicas = 3
            - Handon Tạo 1 replicaset gọi là version 1, rồi sau đố update relicateset ver 1 thành  version 2. Rồi apply sao cho các pod vói cấu hình v1 thành pod với cấu hình ver 2 (Như là phải clone ra 1 file khác thì mới apply dc) ⇒ Tạo v1 xong mun thành v2 thì phải tạo v2 sau đó delete v1. Chú hog không như deployment sẽ support mình tự động delete các pod của v1 và thay  thành pod của v2
            - Handon thử scale 1 ReplicaSet có sẵn = CLI (So sánh khác biết với deployment)
            
        - Deployment
            - Handon Tạo pod nginx bằng deployment với replicas = 3
            - Handon lại ReplicaSet handon thứ 2 bằng Deployment khi này mình hog phải clone ra 1 file khác mà sữa trực tiếp trên file ver1 lun
            - Handon xem lại history deployment của handon trên và roll back lại version trước đó ⇒ sau đo cói lại history deployment để xem có gì thay đổi
            - Handon thử scale 1 deployment có sẵn = CLI
            - Deployment Strategry
                - Handon Rolling-Update  - tìm hiểu thử maxUnavailable and maxSurge
                - Handon ReCreate
                - Ref
                    - [https://spot.io/resources/kubernetes-autoscaling/5-kubernetes-deployment-strategies-roll-out-like-the-pros/#:~:text=MaxSurge specifies the maximum number,%2C default value is 25%25](https://spot.io/resources/kubernetes-autoscaling/5-kubernetes-deployment-strategies-roll-out-like-the-pros/#:~:text=MaxSurge%20specifies%20the%20maximum%20number,%2C%20default%20value%20is%2025%25).
        
        - Horizontal Pod Autoscaler (HPA) (HPA sẽ quản lý deployment or replicaset, để trigger init or termina pod)
            - Handon min replica =5 và max 10 vs điều kiện scale up là util cpu hơn 10%. Làm sao cho scale up to 10 pod để thấy đc quá trình của nó (sài apt install wrk )
    
- StatefulSet
    - Handon tạo 1 StatefulSet với pod nginx và compare thử pod ở StatefulSet và Deployment
    - Handon tạo 1 StatefulSet với pod nginx và service cho các pod đó. Và đừng 1 con pod và call tới pod nginx (Mục đích để thấy được cái connect string sẽ khong bao giờ đổi ứng dụng làm connection string cho database)

- DaemonSet
    - Handon thử tạo 1 deamonset xem nó có khởi tạo pod ở tất cả các node hog ? ⇒ Thử delete 1 pod ở 1 node xem nó thế nào ?
    
- Job
    - Handon thử tại 1 Job tìm hiều completions, backoffLimit, parallelism, và activeDeadLineSeconds
    
- CronJob
    - Handon tạo 1 CronJob với schedule 5m 1 lần (xem thử crontab guru) ⇒ xem thử cronjob nó tạo job và pod
        
        

- Volume
    - EmphemeralVolume
        - Handon thử triển khai thử EmphemeralVolumne cho 1 pod. Rồi thử exec vào pod đó nghịch thử tạo file trong thư mục đó rồi restart lại pod xem có gì xảy ra ?
    
    - HostPathVolume
        - Handon thử tạo 1 pod nginx và mount file index.html từ volume vào pod nginx
        
    - PersistenceVolume
        - Handon
            - Tạo PersistentVolume với hostPath
            - Tạo PersistentVolumeClaim binding với PersistentVolume trên
            - (Thử xóa PersistentVolumeClaim trên là tạo 1 PersistentVolumeClaim mới là binding nó để  sao cho status  PersistentVolume là Bound)
            - Tạo 1 pod nginx sử dụng cái PersistentVolume này
            - Binding volume sao cho vào thử mục html của nginx
    
    - Configmap
        - Handon
            - Tạo 1 configmap cho nginx dạng key: file
            - Tạo 1 pod nginx với configmap trên
            - Thử edit configmap = CLI rồi kiểm tra pod có được apply hong
        
        - Handon
            - Tạo configmap cho mongodb dạng key: value
            - Vd ở 1 pod express muốn sài config trên như 1 env thì sao
        
    - Secret
        - Handon
            - Tạo secret key gồm username vs passworld
            - Thử CLI describe xem có xem được value trong secret key khong
            - Tạo 1 pod mongo với  username vs passworld trên
            - Thử coi xem (service account tokenk8s)
            
        
- Role-Based Access Controll
    - Service Account
        - Handon
            - Đừng ở node master (hay đứng trong 1 pod) thử hiện send request tới control-pannel của k8s để lấy các pod với —cacert and —header Authorization
            - Tạo 1 Role
            - Tạo 1 RoleBinding với subject có kind ServiceAccount, name = default để binding với Role trên
            - Thử hiện send request lại tới control-pannel xem được hong. Tại khi này mình có permission rồi
            
        - Handon
            - Tạo 1 service account
            - Tạo 1 pod và modify lại nó thuộc service account trên
            - Thử hiện lại Handon trên để lấy ra danh sách cách pod của service account đó
        
    - User
        - Handon
            - Thử kubectl config view để xem danh sách user vs config user
            - Tạo client certificate and client key từ đó tạo ra User trong k8s
            - Tạo 1 context với user trên
            - Đổi cái currnet context thành context trên
            - Kiểm tra hoạt động authorization trên user work trên k8s chưa ⇒ phải chưa
            - Tạo 1 role vs rolebinding binding tới User trên
            - Kiểm tra lai xem authorization có work chưa ⇒ phải rồi
            - Thực hành sao cho User trên chỉ có quyền trên namespace development thoi
            
    - Group
        - Handon
            - Tạo client certificate and client key từ đó tạo ra User trong k8s
            - Tạo 1 context với user trên
            - Tạo môt ClusterRole và một ClusterRoleBinding
            - Attach User trên vào ClusterRole
            
- CI/CD Jenkins
    - Handon
        - Setup jenkins trong kubernets
        - Coi thử ConfigureCloud trên Jenkins UI
        - Ở Nashtech là Setup jenkins trên 1 con EC2
        
    

- Terraform
