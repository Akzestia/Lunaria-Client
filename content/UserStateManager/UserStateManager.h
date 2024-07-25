#ifndef USER_STATE_MANAGER_H
#define USER_STATE_MANAGER_H


class UserStateManager
{   
public:
    UserStateManager();
    ~UserStateManager();

    void loadUserState();
    void saveUserState();
    void setUserState(const QString &key, const QVariant &value);
    QVariant getUserState(const QString &key, const QVariant &defaultValue = QVariant()) const;
}

#endif // USER_STATE_MANAGER_H