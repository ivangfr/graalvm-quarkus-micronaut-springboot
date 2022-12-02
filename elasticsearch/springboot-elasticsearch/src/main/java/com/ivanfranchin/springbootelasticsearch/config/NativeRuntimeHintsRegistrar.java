package com.ivanfranchin.springbootelasticsearch.config;

import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.auth.RFC2617Scheme;
import org.springframework.aot.hint.RuntimeHints;
import org.springframework.aot.hint.RuntimeHintsRegistrar;

import java.util.HashMap;

public class NativeRuntimeHintsRegistrar implements RuntimeHintsRegistrar {

    @Override
    public void registerHints(RuntimeHints hints, ClassLoader classLoader) {
        hints.serialization().registerType(BasicScheme.class);
        hints.serialization().registerType(RFC2617Scheme.class);
        hints.serialization().registerType(HashMap.class);
    }
}
