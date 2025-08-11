API Automation Project

This project is an **API Test Automation Framework** built using [Karate](https://github.com/karatelabs/karate) and **Java**, designed to test REST API endpoints efficiently.
It follows a clean folder structure, reusable test components, and is easy to extend for new endpoints.

🚀 Features

* **Karate Framework** for BDD-style API testing.
* **Maven** for build and dependency management.
* Separate **test data** and **API path configuration** files for reusability.
* Supports **positive and negative test cases**.
* Simple **command-line execution** for running all tests in one go.
* Easy to integrate into **CI/CD pipelines**.

---

## 📂 Project Structure

```
myproject/
│
├── src/test/java/                # Test scripts
│   ├── features/                  # Feature files for API endpoints
│   ├── resources/                 # Test data & configuration files
│
├── pom.xml                        # Maven dependencies and build configuration
└── README.md                      # Project documentation
```

---

## 🔧 Tech Stack

* **Language:** Java
* **Framework:** Karate
* **Build Tool:** Maven
* **Version Control:** Git & GitHub

---

## 🧪 How to Run Tests

### 1️⃣ Clone the repository

```bash
git clone https://github.com/Amogha-g-kulkarni/API-Automation-project.git
cd API-Automation-project
```

### 2️⃣ Install dependencies

```bash
mvn clean install
```

### 3️⃣ Run all tests

```bash
mvn test
```

---

## 📊 Reporting

Karate automatically generates HTML reports after test execution:
`target/karate-reports/karate-summary.html`

---

## 📌 Example Scenarios

* **Register User** (valid email & password)
* **Register Without Password** (negative test)
* Easy to extend with other endpoints.

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss your ideas.