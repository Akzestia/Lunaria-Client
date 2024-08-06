# Find Qt6 and its components
find_package(Qt6 6.7 REQUIRED COMPONENTS Core Gui Qml Quick)

# Find other necessary packages (like Protobuf, Abseil, etc.)
find_library(PROTOBUF_LIB NAMES protobuf PATHS ${CMAKE_CURRENT_SOURCE_DIR}/protobuf)
find_library(ABSL_LOG_INTERNAL_CHECK_OP_LIB NAMES absl_log_internal_check_op PATHS ${CMAKE_CURRENT_SOURCE_DIR}/absl-libs)
find_library(ABSL_LOG_INTERNAL_MESSAGE_LIB NAMES absl_log_internal_message PATHS ${CMAKE_CURRENT_SOURCE_DIR}/absl-libs)
find_library(ABSL_CORD_LIB NAMES absl_cord PATHS ${CMAKE_CURRENT_SOURCE_DIR}/absl-libs)

# Function to link common libraries to a target
function(link_common_libraries target)
    target_link_libraries(${target} PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        ${PROTOBUF_LIB}
        ${ABSL_LOG_INTERNAL_CHECK_OP_LIB}
        ${ABSL_LOG_INTERNAL_MESSAGE_LIB}
        ${ABSL_CORD_LIB}
        pqxx
        crypto
        stdc++
        pthread
        lua
    )
endfunction()
