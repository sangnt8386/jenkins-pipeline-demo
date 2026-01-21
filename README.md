# 🚀 Python Feedback App: End-to-End DevSecOps Pipeline

Dự án thực hiện chuyển đổi ứng dụng **Python** truyền thống sang kiến trúc **Cloud-Native**. Toàn bộ vòng đời phát triển được tự động hóa qua quy trình **CI/CD** hiện đại, áp dụng tiêu chuẩn **GitOps** và bảo mật **DevSecOps**.



---

## 🏗️ Quy trình hệ thống (Workflow)

Hệ thống được thiết kế theo luồng khép kín (Closed-loop) đảm bảo tính liên tục và an toàn:

### 🔹 Continuous Integration (CI)
* **Orchestrator:** **Jenkins** điều phối toàn bộ pipeline dưới dạng code (Pipeline as Code).
* **Code Quality:** Phân tích mã nguồn tự động với **SonarQube** (Static Code Analysis).
* **Containerization:** Đóng gói ứng dụng bằng **Docker**, đảm bảo tính nhất quán môi trường.
* **Security:** Quét lỗ hổng hình ảnh (CVEs) bằng **Trivy Scan** trước khi đẩy lên Registry.

### 🔹 Continuous Delivery (CD)
* **GitOps Model:** Sử dụng **ArgoCD** để quản lý trạng thái thực tế của cụm máy chủ.
* **Auto-Update:** Jenkins tự động cập nhật **Image Tag** mới vào **Manifest Repo** trên GitHub.
* **Deployment:** ArgoCD tự động đồng bộ hóa ứng dụng lên cụm **Kubernetes (K8s)** ngay khi có thay đổi.



---

## 🛠️ Công cụ & Công nghệ
* **Ứng dụng:** Python.
* **Hạ tầng:** Docker, Kubernetes (EKS/Local Cluster).
* **CI/CD & GitOps:** Jenkins, ArgoCD.
* **Bảo mật:** SonarQube, Trivy Scan.
* **Quản lý mã nguồn:** Git (GitHub).

---

## 🌟 Kết quả đạt được
* **Tự động hóa 100%:** Loại bỏ hoàn toàn thao tác thủ công từ khâu Code đến Deployment.
* **Shift-left Security:** Phát hiện sớm các rủi ro bảo mật ngay trong quá trình Build.
* **Scalability:** Ứng dụng sẵn sàng vận hành trên Production với khả năng tự phục hồi và mở rộng của K8s.


