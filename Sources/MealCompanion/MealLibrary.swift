import Foundation

enum MealLibrary {
    static let all: [MealOption] = {
        var meals: [MealOption] = []

        func add(_ names: [String], category: MealCategory, note: String, symbol: String, moods: Set<MealMood>, price: Int) {
            meals += names.map { MealOption($0, category, note, symbol, moods, price) }
        }

        add([
            "大米先生", "王胜利", "盖浇饭", "卤肉饭", "黄焖鸡米饭", "小碗菜",
            "自选快餐", "木桶饭", "老乡鸡", "乡村基", "南城香", "小炒黄牛肉饭",
            "鱼香肉丝盖饭", "番茄炒蛋盖饭", "麻婆豆腐盖饭", "宫保鸡丁盖饭"
        ], category: .chinese, note: "楼下或外卖都很好找", symbol: "takeoutbag.and.cup.and.straw", moods: [.dry, .spicy, .comforting], price: 28)

        add([
            "兰州牛肉面", "重庆小面", "沙县拌面", "炸酱面", "酸辣粉", "桂林米粉",
            "云南米线", "馄饨面", "热干面", "麻辣烫", "砂锅米线", "越南米粉",
            "裤带面", "日式拉面", "港式炒粉", "螺蛳粉", "刀削面", "葱油拌面",
            "武汉热干面", "牛肉板面", "羊肉烩面", "肠粉", "土豆粉", "冒菜"
        ], category: .noodles, note: "出餐快，也能吃热乎", symbol: "water.waves", moods: [.comforting, .spicy, .soup, .dry], price: 24)

        add([
            "石锅拌饭", "泡菜汤饭", "炸鸡饭", "辣白菜炒饭", "韩式牛肉汤饭",
            "韩式拌饭", "部队锅", "韩式烤肉饭", "泡菜五花肉饭", "韩式冷面"
        ], category: .korean, note: "想吃重一点时的稳妥选择", symbol: "flame", moods: [.comforting, .spicy, .dry, .soup], price: 34)

        add([
            "泰式打抛饭", "泰式咖喱鸡饭", "海南鸡饭", "越南春卷", "越南牛肉粉",
            "冬阴功粉", "新加坡叻沙", "泰式炒河粉", "猪脚饭", "咖喱牛腩饭"
        ], category: .southeastAsian, note: "商场或园区附近常能找到", symbol: "leaf", moods: [.spicy, .dry, .soup], price: 36)

        add([
            "麦当劳", "肯德基", "汉堡王", "赛百味", "华莱士", "达美乐",
            "必胜客", "意面套餐", "鸡肉卷套餐", "汉堡套餐", "披萨简餐", "贝果三明治"
        ], category: .western, note: "赶时间时，附近总有一家", symbol: "fork.knife", moods: [.comforting, .dry], price: 32)

        add([
            "串饼", "面包简餐", "烤冷面", "肉夹馍", "手抓饼", "煎饼果子",
            "锅贴", "生煎", "蒸饺", "烧麦", "便利店便当", "饭团加茶叶蛋",
            "关东煮", "泡面加鸡蛋", "饺子馆水饺", "麻辣拌", "鸡蛋灌饼", "烤肠饭团"
        ], category: .snacks, note: "不为难自己，先把饭吃了", symbol: "clock", moods: [.comforting, .dry, .soup, .light], price: 20)

        return meals
    }()
}
