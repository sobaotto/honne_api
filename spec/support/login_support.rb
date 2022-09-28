module LoginSupport
    # 疑問：この引数の取り方は、問題ないか？
    # 「user」と「emailとpassword」だと粒度が違うと思う
    def login(user: nil, email: nil, password: nil)
        login_params = { 
                email: email || user&.email,
                password: password || user&.password
            }
        post "/login", params: login_params
    end
end
