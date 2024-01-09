package mysql

import (
	"service/{{.ServiceName}}/internal/repository"

	"gorm.io/gorm"

	"github.com/starfork/stargo"
	"github.com/starfork/stargo/logger"
	"github.com/starfork/stargo/store/mysql"

	pb "service/{{.ServiceName}}/pkg/pb/{{.ServiceName}}"
)

type Repo struct {
	db     *gorm.DB
	logger logger.Logger
}

func New(app *stargo.App) repository.{{ucwords .ServiceName}}Repository {
	db := app.Store("mysql").(*mysql.Mysql).GetInstance()

	r := &Repo{
		db:     db,
		logger: app.GetLogger(),
	}
	//r.migrate()

	return r
}

func (e *Repo) migrate() {
	e.db.AutoMigrate( 
	)
}
