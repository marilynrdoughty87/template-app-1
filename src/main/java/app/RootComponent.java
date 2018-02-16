package app;

import javax.annotation.PostConstruct;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Component;

@Slf4j
@Component
public class RootComponent {

    @PostConstruct
    void init() {
        log.info("Hello from root!");
    }

}
