package mysql

import (
	"service/{{.ServiceName}}/internal/repository"

	"go.uber.org/zap"
	"gorm.io/gorm"

	"github.com/starfork/stargo"

	pb "service/{{.ServiceName}}/pkg/pb/{{.ServiceName}}"
)

type Repo struct {
	db     *gorm.DB
	logger *zap.SugaredLogger
	//app *app.App
	//uid *uid.UID //partner
	//sfid *sf.Sonyflakes
}

func New(app *stargo.App) repository.{{ucwords .ServiceName}}Repository {
	db := app.GetMysql().GetInstance()

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
