set(CMAKE_AUTORCC ON)

qt_add_resources(LunariaClientApp "translations"
    PREFIX "/translations"
    FILES translations_ja.qm
    FILES translations_uk.qm
)
