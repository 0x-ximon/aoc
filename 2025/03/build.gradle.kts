plugins {
    kotlin("jvm") version "2.3.0"
    application
}

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
}

sourceSets {
    main {
        kotlin {
            setSrcDirs(listOf("src"))
            exclude("*_test.kt")
        }
    }

    test {
        kotlin {
            setSrcDirs(listOf("src"))
            include("*_test.kt")
        }
    }
}

application {
    mainClass.set("MainKt")
}

tasks.test {
    useJUnitPlatform()
}
