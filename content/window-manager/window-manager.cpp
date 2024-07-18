#include "window-manager.h"

WindowManager::WindowManager(QQmlApplicationEngine *engine, QObject *parent)
    : QObject(parent), m_engine(engine) {}

void WindowManager::startLoginProcess() {
  QTimer::singleShot(0, [this]() {
    QObject *loginWindow = m_engine->rootObjects().first();
    loginWindow->setProperty("visible", false);

    m_engine->load(QUrl(QStringLiteral("qrc:/qt/qml/content/App.qml")));
    if (m_engine->rootObjects().isEmpty()) {
      qWarning() << "Failed to load main.qml";
      return;
    }
  });
}

void WindowManager::startSignUpProcess() {
  QTimer::singleShot(0, [this]() {
    QList<QObject *> rootObjects = m_engine->rootObjects();
    bool isFullScreen = false;
    if (!rootObjects.isEmpty()) {
      QObject *currentRoot = rootObjects.first();
      QQuickWindow *currentWindow = qobject_cast<QQuickWindow *>(currentRoot);
      if (currentWindow) {
        isFullScreen = currentWindow->visibility() == QQuickWindow::FullScreen;
      }
      delete currentRoot;
    }

    m_engine->load(QUrl(QStringLiteral("qrc:/qt/qml/content/SignUp.qml")));
    if (m_engine->rootObjects().isEmpty()) {
      qWarning() << "Failed to load SignUp.qml";
      return;
    }

    QObject *newRoot = m_engine->rootObjects().first();
    QQuickWindow *newWindow = qobject_cast<QQuickWindow *>(newRoot);
    if (isFullScreen && newWindow) {
      newWindow->setVisibility(QQuickWindow::FullScreen);
    }
  });
}

void WindowManager::startSignInProcess() {
  QTimer::singleShot(0, [this]() {
    QList<QObject *> rootObjects = m_engine->rootObjects();
    bool isFullScreen = false;
    if (!rootObjects.isEmpty()) {
      QObject *currentRoot = rootObjects.first();
      QQuickWindow *currentWindow = qobject_cast<QQuickWindow *>(currentRoot);
      if (currentWindow) {
        isFullScreen = currentWindow->visibility() == QQuickWindow::FullScreen;
      }
      delete currentRoot;
    }

    m_engine->load(QUrl(QStringLiteral("qrc:/qt/qml/Main/main.qml")));
    if (m_engine->rootObjects().isEmpty()) {
      qWarning() << "Failed to load SignIn.qml";
      return;
    }

    QObject *newRoot = m_engine->rootObjects().first();
    QQuickWindow *newWindow = qobject_cast<QQuickWindow *>(newRoot);
    if (isFullScreen && newWindow) {
      newWindow->setVisibility(QQuickWindow::FullScreen);
    }
  });
}