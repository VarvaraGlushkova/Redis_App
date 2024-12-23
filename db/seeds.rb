@fill_txt = "Bionore and Aden had been friends for what felt like an eternity. They met in college, bonding over late-night pizza and study sessions. Over time, their friendship evolved into something more... casual. They both agreed on a friends-with-benefits arrangement, and it seemed like the perfect solution. No strings attached, no drama, just fun. As the months went by, Aden found himself growing more and more attached to Bionore. He couldn't quite put his finger on when it started, but he remembered the way his heart skipped a beat when she smiled at him, the way his hands itched to touch her whenever she was near. He tried to brush it off as mere infatuation, but deep down, he knew it was something more."

@theme_name = [ "#fonts", "#furniture", "#branding", "#merch", "#logo", "#navigation" ]

@comment_text = [ "Этот дизайн настолько минималистичен, что я чувствую себя виноватым, нажимая на кнопку.", "Я видел сайты из 90-х с более современной графикой.", "Навигация в этом интерфейсе – как поиск выхода из лабиринта с завязанными глазами.", "Цветовая схема напоминает мне радугу после стирки.", "Кнопки такие маленькие, что мне нужен микроскоп, чтобы на них нажать.", "Я пытался прокрутить страницу, но вместо этого случайно вызвал духов.", "Дизайн настолько интуитивно понятный, что я до сих пор не понимаю, как им пользоваться.", "Шрифт такой мелкий, что мне пришлось увеличить масштаб до 500%, чтобы прочитать текст.", "Кажется, дизайнер вдохновлялся ранними версиями Paint.", "Я кликнул на кнопку и мой компьютер завис. Думаю, это была пасхалка.", "Этот интерфейс выглядит так, будто его создавали в Microsoft Word.", "Я случайно закрыл вкладку, потому что иконка закрытия больше, чем контент.", "Навигационное меню спрятано так хорошо, что я, наверное, никогда его не найду.", "Этот интерфейс – настоящий тест на терпение.", "Дизайн такой яркий, что у меня заболели глаза.", "Я пытался найти кнопку \"Связаться с нами\", но, кажется, разработчики не хотят, чтобы с ними связывались.", "Этот интерфейс – как путешествие во времени, только в худшем смысле.", "Я так долго ждал загрузки страницы, что успел написать роман.", "Этот дизайн настолько запутанный, что я чувствую себя хакером, пытаясь им пользоваться.", "Я уверен, что где-то здесь спрятана игра \"Где's Waldo?\".", "Этот интерфейс — шедевр... абсурда.", "Я пытался зарегистрироваться, но форма запросила мой номер социального страхования и группу крови.", "Дизайн такой оригинальный, что я даже не знаю, как его описать.", "Я чувствую, что мне нужен PhD в области дизайна, чтобы понять этот интерфейс.", "Кажется, кто-то вылил на клавиатуру ведро краски и назвал это дизайном.", "Я случайно нажал на рекламу и скачал вирус. Спасибо, дизайнеры!", "Я пытался найти информацию на сайте, но сдался и воспользовался Google.", "Этот дизайн настолько плох, что он даже хорош. Почти." ]


@words = @fill_txt.downcase.gsub(/[-.—,':()]/, '').gsub(/  /, ' ').split(' ')

def seed
  reset_db
  create_users(10)
  create_theme(6)
  create_task(30)
  create_answer(10)
  create_comment(10)
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end


def create_users(quantity)
  i = 0

  quantity.times do
    user_data = {
      email: "redis_#{i}@email.com",
      password: 'testtest'
    }

    # if i == 7
    #   user_data[:admin] = true
    # end

    user = User.create!(user_data)
    puts "User created with id #{user.id}"

    i += 1
  end
end

def create_title
  title_n = []

  (1..4).to_a.sample.times do
    title_n << @words.sample
  end

  titlename = title_n.join(' ').capitalize + '.'
end

# def create_theme_title
#   @theme_name.sample
# end

def create_description
  description_n = []

  (10..100).to_a.sample.times do
    description_n << @words.sample
  end

  descriptionst = description_n.join(' ').capitalize + '.'
end

def create_text
  text_n = []

  (10..300).to_a.sample.times do
    text_n << @words.sample
  end

  textn = text_n.join(' ').capitalize + '.'
end


def upload_random_taskimg
  uploader = TaskImageUploader.new(Task.new, :image)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, "public/autoupload/taskimg", "*")).sample))
  uploader
end

def upload_random_answerimg
  uploader = AnswerImgUploader.new(Answer.new, :answer_img)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, "public/autoupload/answerimg", "*")).sample))
  uploader
end
# def upload_random_cover
#   uploader = CoverUploader.new(Story.new, :cover)
#   uploader.cache!(File.open(Dir.glob(File.join(Rails.root, "public/autoupload/covers", "*")).sample))
#   uploader
# end


def create_task(quantity)
  themes = Theme.all

  puts themes

  if themes.empty?
    puts "No Theme available to create Task to it."
    return
  end

  themes.each do |theme|
    task_count = quantity
    task_count.times do |i|
      user = User.all.sample
      task = Task.create!(
        name: create_title,
        descroption: create_description,
        image: upload_random_taskimg,


        theme_id: theme.id,
        user_id: user.id

      )
      puts "Task with id #{task.id} was made for Theme with id #{theme.theme_title}"
    end
  end


  # quantity.times do
  #   # user = User.all.sample
  #   task = Task.create(name: create_title, descroption: create_description, image: upload_random_taskimg, theme_id: theme.id)
  #   puts "Task with id #{task.id} and title #{task.name} was made!"
  # end
end


def create_answer(quantity)
  tasks = Task.all

  puts tasks

  if tasks.empty?
    puts "No Task available to create Answer to it."
    return
  end

  tasks.each do |task|
    answer_count = quantity
    answer_count.times do |i|
      user = User.all.sample
      answer = Answer.create!(
        user_name: create_title,
        description: create_description,
        answer_img: upload_random_answerimg,

        task_id: task.id,
        user_id: user.id

      )
      puts "Answer with id #{answer.id} was made for Task with id #{task.id}"
    end
  end
end

def create_comment(quantity)
  answers = Answer.all

  puts answers

  if answers.empty?
    puts "No Answer available to create Comment to it."
    return
  end

  answers.each do |answer|
    comment_count = quantity
    comment_count.times do |i|
      user = User.all.sample
      comment = Comment.create!(
        user_name_title: create_title,
        body_content: @comment_text.sample,
        answer_id: answer.id,
        user_id: user.id

      )
      puts "Comment with id #{comment.id} was made for Answer with id #{answer.id}"
    end
  end
end

def create_theme (quantity)
  quantity.times do
    theme = Theme.create(
      theme_title: @theme_name.sample,
      theme_descr: create_description
    )

    theme.save!

    puts "Theme with name #{theme.theme_title} was created"
  end
end


seed
