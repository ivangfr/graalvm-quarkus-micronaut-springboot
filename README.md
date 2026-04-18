# graalvm-quarkus-micronaut-springboot

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-ivan.franchin-FFDD00?logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/ivan.franchin)


The goal of this project is to compare some Java Microservices Frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/index.html). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Proof-of-Concepts & Articles

On [ivangfr.github.io](https://ivangfr.github.io), I have compiled my Proof-of-Concepts (PoCs) and articles. You can easily search for the technology you are interested in by using the filter. Who knows, perhaps I have already implemented a PoC or written an article about what you are looking for.

## Additional Readings

- \[**Medium**\] [**Java Microservice Framework’s Battles: Quarkus vs Micronaut vs Spring Boot**](https://medium.com/@ivangfr/java-microservice-frameworks-battles-quarkus-vs-micronaut-vs-spring-boot-2321dc5712ae)
- \[**Medium**\] [**Unveiling the Java Microservice Frameworks Battle: Insights, Earnings, and GitHub Contributions**](https://medium.com/@ivangfr/unveiling-the-java-microservice-frameworks-battle-insights-earnings-and-github-contributions-6540cd0a0a1a)
- \[**Medium**\] [**Battle: Quarkus 3.7.2 vs. Micronaut 4.3.1 vs. Spring Boot 3.2.2**](https://medium.com/@ivangfr/battle-quarkus-3-7-2-vs-micronaut-4-3-1-vs-spring-boot-3-2-2-8d6765e15e45)
- \[**Medium**\] [**Battle: Quarkus 3.12.0 vs. Micronaut 4.5.0 vs. Spring Boot 3.3.1**](https://medium.com/@ivangfr/battle-quarkus-3-12-0-vs-micronaut-4-5-0-vs-spring-boot-3-3-1-b9a4424fc52f)
- \[**Medium**\] [**Battle: Quarkus 3.14.2 vs. Micronaut 4.6.1 vs. Spring Boot 3.3.3**](https://medium.com/@ivangfr/battle-quarkus-3-14-2-vs-micronaut-4-6-1-vs-spring-boot-3-3-3-41947196fb31)
- \[**Medium**\] [**Battle: Quarkus 3.15.1 vs. Micronaut 4.6.3 vs. Spring Boot 3.3.4**](https://medium.com/@ivangfr/battle-quarkus-3-15-1-vs-micronaut-4-6-3-vs-spring-boot-3-3-4-9ae4a7cefac6)
- \[**Medium**\] [**Battle: Quarkus 3.21.0 vs. Micronaut 4.7.6 vs. Spring Boot 3.4.4**](https://medium.com/@ivangfr/battle-quarkus-3-21-0-vs-micronaut-4-7-6-vs-spring-boot-3-4-4-07991c9fda04)
- \[**Medium**\] [**Battle: Quarkus 3.24.3 vs. Micronaut 4.9.0 vs. Spring Boot 3.5.3**](https://medium.com/@ivangfr/battle-quarkus-3-24-3-vs-micronaut-4-9-0-vs-spring-boot-3-5-3-49e496b3f365)


## Categories

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Latest Framework Version Used

| Framework   | Version |
|-------------|---------|
| Quarkus     | 3.34.3  |
| Micronaut   | 4.10.11 |
| Spring Boot | 4.0.5   |

## Thread Pool Configuration

For fair benchmarking across frameworks, the Quarkus and Micronaut applications are configured to use 200 worker threads, matching Spring Boot's default Tomcat thread pool.

| Framework   | Configuration Property | Default (without config) |
|-------------|------------------------|--------------------------|
| Spring Boot | `server.tomcat.threads.max=200` (Tomcat default) | 200 |
| Quarkus     | `quarkus.thread-pool.max-threads=200` | Math.max(8×CPU, 200) |
| Micronaut   | `micronaut.executors.io.number-of-threads=200`<br>`micronaut.executors.io.type=fixed` | 2 × CPU |

### Applications Updated

- **simple-api**: All three frameworks
- **jpa-mysql**: All three frameworks
- **elasticsearch**: All three frameworks
- **kafka-producer**: All three frameworks (has HTTP endpoints)
- **kafka-consumer**: Not updated (no HTTP endpoints)

---

## Blocking vs Non-Blocking Behavior

The sample applications use blocking endpoints (synchronous return types) across all frameworks:

| Framework | Embedded Server | Endpoint Behavior |
|-----------|-----------------|-------------------|
| Spring Boot | Tomcat (blocking) | **Blocking** |
| Quarkus | Vert.x (non-blocking) | **Blocking** (smart dispatch → worker thread) |
| Micronaut | Netty (non-blocking) | **Blocking** (`@ExecuteOn(TaskExecutors.IO)`) |

### Key Points

- **Spring Boot**: Uses `@RestController` with synchronous return types. Spring MVC on Tomcat is blocking by default.
- **Quarkus**: Uses JAX-RS (`@Path`, `@GET`). Quarkus uses smart dispatch based on method return type:
  - Returns `T` → Worker thread (blocking)
  - Returns `Uni<T>` → I/O thread (non-blocking)
  - All sample endpoints return synchronous types, so they run on worker threads.
- **Micronaut**: Uses `@Controller` with `@ExecuteOn(TaskExecutors.BLOCKING)` annotation. Without this, Micronaut defaults to non-blocking on Netty's I/O threads.

> **Note**: Even though Quarkus and Micronaut use non-blocking servers (Vert.x/Netty), the endpoint behavior depends on the code within the endpoint. Blocking endpoints run on worker threads in all frameworks.

## Prerequisites

- [`Java 17`](https://www.oracle.com/java/technologies/downloads/#java17) or higher;
- A containerization tool (e.g., [`Docker`](https://www.docker.com), [`Podman`](https://podman.io), etc.)
- [`Bash 4.0`](https://www.gnu.org/software/bash/) or higher (macOS ships with Bash 3.2; install via `brew install bash`)

## Docker Images

The application’s JVM and Native Docker images can be found in [this Docker Hub link](https://hub.docker.com/search?q=ivanfranchin).

## Bash scripts

We've implemented bash scripts to build, manage, and verify Docker images for the frameworks comparison.

- **build-docker-images.sh**
  Packages JAR files (via Maven) and builds Docker images for JVM or Native applications. Supports targeting all apps, by framework (quarkus/micronaut/springboot), by type (simple-api/jpa-mysql/kafka/elasticsearch), or specific apps.

- **remove-docker-images.sh**
  Removes Docker images. Supports targeting all, by framework, by type, or specific apps.

- **push-docker-images.sh**
  Pushes Docker images to Docker Hub (or another registry). Supports targeting all, by framework, by type, or specific apps.

- **tag-docker-images.sh**
  Tags local Docker images with specific version tags (e.g., v1.0, latest). Supports targeting all, by framework, by type, or specific apps.

- **verify-docker-images.sh**
  Starts Docker containers and runs HTTP tests to verify applications are working correctly. Tests different scenarios: simple-api, jpa-mysql, kafka (producer/consumer), elasticsearch. Also exports results to CSV.

**Common options for all scripts:**
- `--builder=BUILDER` — Container builder (podman or docker)
- `--quarkus-version=TAG` — Quarkus image tag
- `--micronaut-version=TAG` — Micronaut image tag
- `--springboot-version=TAG` — Spring Boot image tag
- `--dry-run` — Show what would be done without executing
- `-h, --help` — Show help

## Support

If you find this useful, consider buying me a coffee:

<a href="https://buymeacoffee.com/ivan.franchin"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="50"></a>

## License

This project is licensed under the [MIT License](./LICENSE).
