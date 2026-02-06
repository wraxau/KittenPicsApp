import UIKit

class ViewController: UIViewController {

    
// Constants
    // сюда будем помещать размеры элементов на экране, чтобы они все были в одном месте
    private enum Constants {
        enum TitleLabel {
            static let width: CGFloat = 100.0
        }
           
    }
    
// Subview - разные view которые будут лежать на нашей основнйо view - то есть элементы экрана
    
    // это реализация лямба функции котоорая сразу возаращет лейбл, который мне нужен
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap one of the buttons to see a cat!"
        label.textColor = .white
        label.numberOfLines = 0
        label.backgroundColor = .orange
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false // чтобы констрейнты работали для лейбла
        return label
    }()
    
    //  lazy - наш элемнт будет инициализировать не сразу, а только когда мы к нему обратимся в коде, это надо, чтобы не было утечек памяти
    private lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setTitle("Left", for: .normal)
        leftButton.setTitleColor(.white, for: .normal)
        leftButton.backgroundColor = .orange
        leftButton.layer.cornerRadius = 12  // закругление
        leftButton.clipsToBounds = true
        leftButton.addAction(
            UIAction { [weak self] _ in
                self?.showPreviousImage()
            }, for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        return leftButton
    
    }()

    private lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setTitle("Right", for: .normal)
        rightButton.setTitleColor(.white, for: .normal)
        rightButton.backgroundColor = .orange
        rightButton.layer.cornerRadius = 12  // закругление
        rightButton.clipsToBounds = true
        rightButton.addAction(
            UIAction { [weak self] _ in
                self?.showNextImage()
            }, for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton

    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true // изображение не будет вылезать за границы
        imageView.contentMode = .scaleAspectFit // изображение сохраняет свои изначальные пропорции
        imageView.image = UIImage(named: images[0])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
// Properties
    
    let images: [String] = ["cat1","cat2","cat3","cat4","cat5","cat6","cat7","cat8","cat9","cat10",]
    private var currentIndex = 0


// Lifecycle - жизенный цикл ViewController - что когда подругжается, происходит и тд. Мы можем вызывать разные методы в разное время

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    deinit { }

//  Методы
    
    // используем Constarints а не Frame, так как Constraints адаптивные. Хотя Frame намного быстрее
    private func configureView() {
        view.backgroundColor = .brown
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ]) // отрицательные контсрейнты надо ставить, если мы ставих их к правой и нижней границе
        
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        
        NSLayoutConstraint.activate([
            
            leftButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            rightButton.topAnchor.constraint(equalTo: leftButton.topAnchor),
                    
                    // Левая кнопка: отступ слева + ширина
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            leftButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            leftButton.heightAnchor.constraint(equalToConstant: 30), // высота
                    
                    // Правая кнопка: отступ справа + ширина = левой
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            // расстояние между кнопками
            leftButton.trailingAnchor.constraint(lessThanOrEqualTo: rightButton.leadingAnchor, constant: -20)
            
        ])
        
    }
    
    private func updateLabel(x: Int) {
        switch x {
        case 0:
            titleLabel.backgroundColor = .red
            titleLabel.text = "Business cat"
        case 1:
            titleLabel.backgroundColor = .blue
            titleLabel.text = "Gloating cat"
        case 2:
            titleLabel.backgroundColor = .gray
            titleLabel.text = "Pomantic cat"
        case 3:
            titleLabel.backgroundColor = .systemMint
            titleLabel.text = "Chill kitten"
        case 4:
            titleLabel.backgroundColor = .systemIndigo
            titleLabel.text = "Mac enjoyer kitten"
        case 5:
            titleLabel.backgroundColor = .magenta
            titleLabel.text = "Screaming kitten"
        case 6:
            titleLabel.backgroundColor = .darkGray
            titleLabel.text = "Official cat"
        case 7:
            titleLabel.backgroundColor = .systemPink
            titleLabel.text = "Cat in the trouble"
        case 8:
            titleLabel.backgroundColor = .purple
            titleLabel.text = "Cute cat"
        case 9:
            titleLabel.backgroundColor = .green
            titleLabel.text = "Selebrity cat"
        default:
            titleLabel.backgroundColor = .cyan
            titleLabel.text = "Typical cat"
        }
    }
    
    private func showNextImage() {
        currentIndex += 1
        if currentIndex >= images.count {
            currentIndex = 0
        }
        updateImage()
        updateLabel(x: currentIndex)
    }

    private func showPreviousImage() {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = images.count - 1
        }
        updateImage()
        updateLabel(x: currentIndex)
    }

    private func updateImage() {
        imageView.image = UIImage(named: images[currentIndex])
    }

}

