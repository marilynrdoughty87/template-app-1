package app;

import javax.annotation.PostConstruct;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Component;

@Slf4j
@Component
public class LibSampleComponent {

    @PostConstruct
    void init() {
        log.info("Hello from lib-sample");
    }

}
