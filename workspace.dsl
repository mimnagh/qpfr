workspace {

    model {

        // People
        quant = person "Quant" "Quant who configures optimization and reviews outputs"
        quantDev = person "Quant Developer" "Developer who provides APIs and builds pipeline"

        // Software System and Containers
        portfolioFramework = softwareSystem "Portfolio Optimization Framework" "Framework for portfolio optimization with pluggable pipeline." {

            dataIngest = container "Data Ingestion Module" "R / httr / readr" "Loads time series data via API or CSV" {
                tags "Data Layer"
            }

            preprocessor = container "Preprocessor" "mlr3pipelines" "Transforms sector and factor data using mlr3 pipeline operators" {
                tags "Data Layer"
            }

            optimizer = container "Optimizer" "mlr3 Learner + nloptr" "Computes optimal sector weights with risk model, constraints, benchmark comparison" {
                tags "Optimizer Layer"

                nloptImpl = component "PortfolioOptimizer" "R6 Learner class (mlr3)" "Implements risk-adjusted strategy with sector bounds, benchmark comparison, IR/TE scoring" {
                    tags "Optimizer Layer"
                }

                riskModel = component "Factor Covariance Matrix" "matrix / Matrix" "Provides factor risk model" {
                    tags "Data Layer"
                }

                benchmarkWeights = component "Benchmark Weights" "named vector / data.table" "Provides benchmark sector weights" {
                    tags "Data Layer"
                }

                alphaScorer = component "Alpha Scorer" "mlr3::Measure" "Computes Alpha" {
                    tags "Scoring Layer"
                }

                irScorer = component "Information Ratio Scorer" "mlr3::Measure" "Computes IR" {
                    tags "Scoring Layer"
                }

                configLoader = component "Config Loader" "YAML + R" "Loads optimizer parameters" {
                    tags "Config Layer"
                }

                optimizerDataProvider = component "Optimizer DataProvider" "R6 class" "Fetches risk model and benchmark weights for optimizer" {
                    tags "Data Layer"
                }

                inputData = component "Input DataFrame" "data.table / tibble" "Sector-level and factor-level time series" {
                    tags "Data Layer"
                }

                optimizerPlugin = component "OptimizerPlugin Interface" "R6 base class / mlr3 Learner interface" "Defines optimization contract" {
                    tags "Optimizer Layer"
                }

                // Relationships AFTER components
                inputData -> optimizerPlugin "Provides data to optimizer interface"
                optimizerPlugin -> nloptImpl "Delegates to optimization implementation"
                nloptImpl -> riskModel "Uses risk model"
                nloptImpl -> benchmarkWeights "Uses benchmark weights"
                nloptImpl -> alphaScorer "Uses alpha scorer"
                nloptImpl -> irScorer "Uses IR scorer"
                configLoader -> optimizerDataProvider "Fetches config-driven data"
                nloptImpl -> optimizerDataProvider "Fetches risk model and benchmark data"
            }

            persistor = container "Result Persistor" "arrow / parquet" "Writes optimization results to storage (internal API)" {
                tags "Storage Layer"
            }

            visualizer = container "Notebook Visualizer" "Quarto + ggplot2 / plotly" "Renders sector weights, performance vs benchmark, IR/TE plots for quantitative review" {
                tags "Visualization Layer"
            }

            benchmarkSource = container "Benchmark Data Source" "Data API / CSV / readr" "Provides benchmark weights and returns for optimization comparison" {
                tags "Data Layer"
            }

            dataProvider = container "DataProvider" "R6 class" "Fetches risk model and benchmark data using model_name, supports pipeline execution" {
                tags "Data Layer"
            }

            pipelineRunner = container "Pipeline Runner" "R (mlr3pipelines)" "Coordinates mlr3 pipeline orchestration and execution" {
                tags "Orchestration Layer"
            }

            dataApi = container "Data API" "plumber / RestRserve" "Serves sector and factor analytics via REST API" {
                tags "Data Layer"
            }

            storage = container "Storage" "Disk/Cloud (arrow / parquet / S3)" "Holds persisted results (external store: disk or cloud)" {
                tags "Storage Layer"
            }

            // Container relationships
            quant -> dataIngest "Uses API / CSV"
            quant -> visualizer "Views reports"
            preprocessor -> optimizer "Transforms data for optimization"
            optimizer -> persistor "Persists optimization results"
            persistor -> visualizer "Provides data for visualization"
            benchmarkSource -> dataProvider "Provides benchmark data"
        }

        // System-level relationships
        quant -> portfolioFramework "Configure and run optimizations"
        quantDev -> portfolioFramework "Provide input data APIs"

        // Deployment Environment
        deployEnv = deploymentEnvironment "Production" {

            deploymentNode quartoNode "RStudio / Quarto Environment" {
                containerInstance visualizer
                containerInstance pipelineRunner
            }

            deploymentNode computeNode "Data + Compute Server" {
                containerInstance dataApi
                containerInstance benchmarkSource
                containerInstance dataProvider
                containerInstance optimizer
                containerInstance storage
            }

            // Deployment relationships
            visualizer -> pipelineRunner "Visualizes pipeline outputs"
            pipelineRunner -> dataApi "Fetches input data"
            pipelineRunner -> dataProvider "Fetches model-dependent data"
            pipelineRunner -> benchmarkSource "Fetches benchmark data"
            pipelineRunner -> optimizer "Triggers optimization"
            optimizer -> storage "Persists optimization results"
        }

    }

    views {

        // Context view
        systemContext portfolioFramework "Portfolio_Optimization_Framework_-_Context" {
            include quant
            include quantDev
            include portfolioFramework
            autolayout lr
        }

        // Container view
        container portfolioFramework "Portfolio_Optimization_Framework_-_Containers" {
            include *
            autolayout lr
        }

        // Component view (Optimizer container)
        component optimizer "Optimizer-Components" {
            include *
            autolayout lr
        }

        // Deployment view
        deployment portfolioFramework deployEnv {
            include *
            autolayout lr
        }

        // Styles
        styles {
            element "Person" {
                background "#08427b"
                color "#ffffff"
                shape person
            }

            element "Data Layer" {
                background "#ffcc99"
                color "#000000"
            }

            element "Optimizer Layer" {
                background "#cfe2f3"
                color "#000000"
            }

            element "Scoring Layer" {
                background "#e06666"
                color "#ffffff"
            }

            element "Config Layer" {
                background "#ffe599"
                color "#000000"
            }

            element "Storage Layer" {
                background "#b6d7a8"
                color "#000000"
            }

            element "Visualization Layer" {
                background "#a4c2f4"
                color "#000000"
            }

            element "Orchestration Layer" {
                background "#d9d2e9"
                color "#000000"
            }

            element "Software System" {
                background "#1168bd"
                color "#ffffff"
            }

            element "Deployment Node" {
                background "#dddddd"
                color "#000000"
            }
        }

        theme default
    }

    // Versioning
    properties {
        version "vR1.1"
    }

    // Documentation
}