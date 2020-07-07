# graalvm-quarkus-micronaut-springboot
## `> book-api`

In this example, we will implement three versions of a Restful API for handling Books using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks. The books information are store in a database.

## Applications

- ### [quarkus-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/quarkus-book-api#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#graalvm-quarkus-micronaut-springboot)
- ### [springboot-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/springboot-book-api#graalvm-quarkus-micronaut-springboot)

## Start environment

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/book-api` folder

- Run the command
  ```
  docker-compose up -d
  ```

- Wait a little bit until `MySQL` is `Up (healthy)`. You can check it by running
  ```
  docker-compose ps
  ```

- Finally, run the script below to initialize the database
  ```
  ./init-db.sh
  ```

## Useful Commands

- **MySQL**

  Docker exec into `mysql` contatiner
  ```
  docker exec -it mysql mysql -uroot -psecret --database bookdb
  ```

  Insite `MySQL monitor` terminal
  ```
  show tables;
  select * from quarkus_books;
  select * from micronaut_books;
  select * from springboot_books;
  ```

## Shutdown

- In a terminal, make sure you are in `graalvm-quarkus-micronaut-springboot/book-api` folder

- To stop and remove docker-compose containers, networks and volumes, run
  ```
  docker-compose down -v
  ```
