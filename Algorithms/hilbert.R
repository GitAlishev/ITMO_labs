library(reshape2)  # нужна для функции melt
library(dplyr)  # для rename и arrange
library(ggplot2)  # отрисовка

# опции отрисовки кривой Гильберта
opt = theme(legend.position="none",
            panel.background=element_rect(fill="white"),
            panel.grid=element_blank(),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            axis.text=element_blank()
)

# Что происходит в цикле? Создается квадратная матрица m:
# - номер строки матрицы: координата x;
# - номер столбца матрицы: координата y.
# Получаем наборы координат (1,1), (2,1) и т.п.
# - элементы матрицы показывают порядок перехода к конкретной координате.
# Результат выполнения функции: таблица с координатами x, y и порядок их прохождения при отрисовке (order).
# Каждая следующая координата соединяется с предыдущей, образуя линию.
# Множество линий образует кривую Гильберта.

hilbert <- function(n) {
    # n - порядок кривой Гильберта

    m <- matrix(1)
    for (i in 1:n) {
        part <- cbind(t(m), m + nrow(m)^2)
        m <- rbind(part, (2*nrow(m))^2 - part[nrow(m):1,] + 1)
    }

    # Развернуть матрицу m в три столбца: x, y и порядок их имплементации.
    melt(m) %>% plyr::rename(c("Var1" = "x", "Var2" = "y", "value"="order")) %>% arrange(order)
}

# geom_path() соединяет наблюдения в том порядке, в котором они появляются в данных.
iteration = 4
ggplot(hilbert(iteration), aes(x, y)) + geom_path() + opt
