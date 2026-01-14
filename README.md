🚀 Modern DevSecOps Pipeline: Python Flask on Kubernetes
Dự án này thực hiện chuyển đổi một ứng dụng Python Flask truyền thống sang kiến trúc Cloud-Native. Toàn bộ vòng đời phát triển phần mềm được tự động hóa thông qua quy trình CI/CD Pipeline chuyên nghiệp, áp dụng tiêu chuẩn GitOps và bảo mật DevSecOps.

🏗️ Quy trình hệ thống (The Workflow)
Hệ thống được thiết kế theo luồng khép kín đảm bảo tính liên tục và an toàn:

Continuous Integration (CI): * Jenkins đóng vai trò điều phối chính (Orchestrator).

Kiểm tra chất lượng mã nguồn tự động với SonarQube (Static Code Analysis).

Đóng gói ứng dụng bằng Docker để đảm bảo tính nhất quán giữa các môi trường.

Kiểm soát an toàn hình ảnh (Image Security) bằng Trivy Scan trước khi đẩy lên Registry.

Continuous Delivery (CD):

Áp dụng mô hình GitOps với ArgoCD.

Jenkins tự động cập nhật phiên bản mới (Image Tag) vào kho lưu trữ cấu hình (Manifest Repo).

ArgoCD tự động theo dõi và đồng bộ trạng thái ứng dụng lên cụm Kubernetes (K8s).

🛠️ Công cụ & Công nghệ sử dụng
Ngôn ngữ & DB: Python (Flask), PostgreSQL.

Hạ tầng: Docker, Kubernetes (EKS/Local Cluster).

CI/CD & GitOps: Jenkins, ArgoCD.

Bảo mật & Chất lượng: SonarQube, Trivy Scan.

Quản lý mã nguồn: Git (GitHub).

🌟 Kết quả đạt được
Tự động hóa 100%: Loại bỏ thao tác thủ công từ khâu Code đến Deployment.

Shift-left Security: Phát hiện lỗ hổng bảo mật và lỗi code ngay trong quá trình Build.

Khả năng mở rộng: Ứng dụng sẵn sàng chạy trên môi trường Production với khả năng tự phục hồi và mở rộng của Kubernetes.
