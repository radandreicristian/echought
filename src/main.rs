use actix_web::{App, HttpServer, Responder, get};

#[get("/hc")]
async fn healthcheck() -> impl Responder {
    "Hello world!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(||{
        App::new()
            .service(healthcheck)})
        .bind(("0.0.0.0", 8000))?
        .run()
        .await
}