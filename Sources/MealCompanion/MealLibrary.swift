import Foundation

enum MealLibrary {
    static let all: [MealOption] = {
        var meals: [MealOption] = []

        func add(_ names: [String], category: MealCategory, note: String, symbol: String, moods: Set<MealMood>, price: Int) {
            meals += names.map { MealOption($0, category, note, symbol, moods, price) }
        }

        add(["黄焖鸡米饭", "鱼香肉丝盖饭", "宫保鸡丁盖饭", "麻婆豆腐盖饭", "小炒肉盖饭", "番茄炒蛋盖饭", "自选快餐", "小碗菜配饭", "木桶饭", "卤肉饭"], category: .chinese, note: "楼下或外卖都很好找", symbol: "takeoutbag.and.cup.and.straw", moods: [.dry, .spicy], price: 25)

        add(["兰州牛肉面", "重庆小面", "沙县拌面", "炸酱面", "酸辣粉", "桂林米粉", "螺蛳粉", "云南米线", "馄饨面", "热干面", "麻辣烫", "砂锅米线"], category: .noodles, note: "出餐快，也能吃热乎", symbol: "water.waves", moods: [.comforting, .spicy, .soup, .dry], price: 22)

        add(["牛肉饭", "照烧鸡腿饭", "日式咖喱鸡排饭", "日式拉面", "饭团套餐", "关东煮"], category: .japanese, note: "连锁店常见，不用费脑子", symbol: "fish", moods: [.comforting, .dry, .soup, .light], price: 30)

        add(["石锅拌饭", "泡菜汤饭", "韩式炸鸡饭", "辣白菜炒饭", "韩式牛肉汤饭"], category: .korean, note: "想吃重一点时的稳妥选择", symbol: "flame", moods: [.comforting, .spicy, .dry, .soup], price: 32)

        add(["越南牛肉粉", "泰式打抛饭", "泰式咖喱鸡饭", "海南鸡饭", "越南春卷套餐"], category: .southeastAsian, note: "商场或园区附近常能找到", symbol: "leaf", moods: [.spicy, .dry, .soup], price: 35)

        add(["麦当劳", "肯德基", "汉堡王", "华莱士", "鸡肉卷套餐", "意面套餐"], category: .western, note: "赶时间时，附近总有一家", symbol: "fork.knife", moods: [.comforting, .dry], price: 30)

        add(["清汤馄饨", "蒸饺", "番茄鸡蛋面", "全麦鸡肉卷", "鸡胸肉沙拉", "紫菜蛋花汤配饭"], category: .light, note: "想吃轻一点，也不饿着", symbol: "drop", moods: [.comforting, .dry, .soup, .light], price: 24)

        add(["便利店便当", "饭团加茶叶蛋", "关东煮", "泡面加鸡蛋", "饺子馆水饺", "麻辣拌", "锅贴", "肉夹馍", "手抓饼", "煎饼果子"], category: .quick, note: "不为难自己，先把饭吃了", symbol: "clock", moods: [.comforting, .dry, .soup], price: 18)

        return meals
    }()
}
