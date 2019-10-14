package com.mycompany;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class SimpleApiResourceTest {

    @Test
    public void testHelloEndpoint() {
        given()
          .when().get("/api/greeting")
          .then()
             .statusCode(200)
             .body(is("{\"message\":\"Hello World!!!\"}"));
    }

}