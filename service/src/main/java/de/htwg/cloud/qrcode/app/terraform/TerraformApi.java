package de.htwg.cloud.qrcode.app.terraform;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@Slf4j
@RestController
@RequestMapping
public class TerraformApi {

    @PostMapping(path = "/secure/apply", consumes = APPLICATION_JSON_VALUE)
    public ResponseEntity<String> applyTerraform(@RequestBody ApplyTerraformDto dto) throws InterruptedException, IOException {
        log.info("Endpoint: /secure/tenant. Name: " + dto.tenantName());

        log.info("Starting process...");
        ProcessBuilder processBuilder = new ProcessBuilder();
        processBuilder.command("sh", "-c", "/terraform apply -auto-approve -var=\"namespace=%s\"".formatted(dto.tenantName));
        processBuilder.directory(new File("/opt/terraform/tenant"));
        //Sets the source and destination for subprocess standard I/O to be the same as those of the current Java process.
        processBuilder.inheritIO();
        Process process = processBuilder.start();

        log.info("Waiting for end...");
        int exitValue = process.waitFor();
        if (exitValue != 0) {
            // check for errors
            String result = new BufferedReader(new InputStreamReader(process.getErrorStream()))
                    .lines().collect(Collectors.joining("\n"));
            log.warn(result);

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }

        log.info("Process ended with a success.");
        return ResponseEntity.status(HttpStatus.OK).body("Successfully applied");
    }

    private record ApplyTerraformDto(String tenantName) {}
}
