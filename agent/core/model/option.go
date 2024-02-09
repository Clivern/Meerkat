// Copyright 2023 Clivern. All rights reserved.
// Use of this source code is governed by the MIT
// license that can be found in the LICENSE file.

package model

import (
	"time"

	"github.com/clivern/mandrill/core/util"
)

// Option struct
type Option struct {
	ID        int       `json:"id"`
	UUID      string    `json:"uuid"`
	Key       string    `json:"key"`
	Value     string    `json:"value"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

// Options struct
type Options struct {
	Options []Option `json:"options"`
}

// LoadFromJSON update object from json
func (o *Option) LoadFromJSON(data []byte) error {
	return util.LoadFromJSON(o, data)
}

// ConvertToJSON convert object to json
func (o *Option) ConvertToJSON() (string, error) {
	return util.ConvertToJSON(o)
}

// LoadFromJSON update object from json
func (o *Options) LoadFromJSON(data []byte) error {
	return util.LoadFromJSON(o, data)
}

// ConvertToJSON convert object to json
func (o *Options) ConvertToJSON() (string, error) {
	return util.ConvertToJSON(o)
}

// IsNil if option is nil
func (o *Option) IsNil() bool {
	return o.ID == 0
}
